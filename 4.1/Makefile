# SPDX-License-Identifier: AGPL-3.0-or-later
SHELL := /bin/bash
include config.mk

BUILD := build
REF   := ref

# сырой сегмент кода вендорского образа (для анализа при построении хуков)
FW_BIN  ?= ../blobs/kit-4100/seg_008c0000.bin
FW_BASE ?= 0x8c0000

.PHONY: all gate toolchain-check symbols ext hook hook-overlay image clean \
	tree rebuild fw anno millicode

all: toolchain-check
	@echo "цели: gate | symbols | ext | image   (см. README.md)"

# проверка, что тулчейн на месте и это тот самый ARCompact
toolchain-check:
	@mkdir -p $(BUILD)
	@test -x "$(AS)" || { echo "нет ассемблера: $(AS)"; echo "переопредели ARC_DIR в config.mk"; exit 1; }
	@$(AS) --version | head -1
	@printf '\tmulu64 r2,r1\n' > $(BUILD)/.probe.s; \
	 $(AS) -mcpu=$(ARC_CPU) -o $(BUILD)/.probe.o $(BUILD)/.probe.s \
	   && echo "mulu64 принят: -mcpu=$(ARC_CPU) верный" \
	   || { echo "mulu64 отвергнут — проверь ARC_CPU"; exit 1; }

# гейт: собрать эталонные инструкции и сверить байты с образом
gate: toolchain-check
	python3 tools/asm_gate.py $(REF)/ASM-REFSET.txt \
	  --as $(AS) --ld $(LD) --objcopy $(OBJCOPY) --cpu $(ARC_CPU)

# справочники из ref/, которые прежде обновлялись только вручную и потому
# отставали от дерева после каждой волны переименований. Гонять после make tree.
.PHONY: refs
refs:
	python3 tools/sm_tables.py     > $(REF)/SM-TABLES.txt
	python3 tools/sm_tables_uc.py  > $(REF)/SM-TABLES-UC.txt
	python3 tools/wait_sites.py --seg uc  > $(REF)/WAIT-SITES-UC.txt
	python3 tools/wait_sites.py --inline  > $(REF)/WAIT-SITES-INLINE.txt
	$(MAKE) symbols
	python3 tools/coverage.py
	python3 tools/audit_names.py

# символы вендорских функций для линковщика
symbols:
	python3 tools/gen_symbols_ld.py --syms $(REF)/SYMS.txt \
	  --out ld/symbols.ld --out-ucode ld/symbols-ucode.ld

EXT_SRC  := $(wildcard src/ext/*.c)
EXT_ASM  := $(wildcard src/ext/*.S)
EXT_OBJ  := $(patsubst src/ext/%.c,$(BUILD)/%.o,$(EXT_SRC)) \
            $(patsubst src/ext/%.S,$(BUILD)/%.o,$(EXT_ASM))
HOOK_LD  := $(wildcard ld/hooks.ld)

# наш код -> свободный хвост fw_code
ext: toolchain-check ld/symbols.ld $(EXT_OBJ)
	@test -n "$(EXT_OBJ)" || { echo "в src/ext/ нет ни одного .c — собирать нечего"; exit 1; }
	$(LD) $(LDFLAGS) -T ld/memory.ld -T ld/symbols.ld $(addprefix -T,$(HOOK_LD)) \
	  -o $(BUILD)/ext.elf $(EXT_OBJ)
	$(OBJCOPY) -O binary -j .text.ext -j .rodata.ext -j .data.ext $(BUILD)/ext.elf $(BUILD)/ext.bin
	@echo "--- размещение ---"
	@$(OBJDUMP) -h $(BUILD)/ext.elf | awk '/\.text\.ext|\.rodata\.ext|\.data\.ext|\.bss\.ext/{printf "  %-12s %8s байт @ 0x%s\n",$$2,$$3,$$4}'
	@echo "--- переходы в вендорский код (bl и хвостовые b) ---"
	@$(OBJDUMP) -d $(BUILD)/ext.elf | grep -E ';[0-9a-f]+ <' | head -20
	@ls -l $(BUILD)/ext.bin

$(BUILD)/%.o: src/ext/%.c
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD)/%.o: src/ext/%.S
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c -o $@ $<

ld/symbols.ld:
	$(MAKE) symbols
# ---- хуки -------------------------------------------------------
# Использование:
#   make hook AT=0x8c2190 HANDLER=ext_on_tx_bcon   # трамплин + ld-фрагмент
#   make ext                                        # собрать наш код
#   make hook-overlay AT=0x8c2190                   # патч-переход для образа
export ARC_BIN

hook:
	@test -n "$(AT)" -a -n "$(HANDLER)" || { echo "нужно: make hook AT=0x... HANDLER=имя"; exit 1; }
	python3 tools/mkhook.py analyze --at $(AT) --handler $(HANDLER) --bin $(FW_BIN) --base $(FW_BASE)

hook-overlay:
	@test -n "$(AT)" || { echo "нужно: make hook-overlay AT=0x..."; exit 1; }
	python3 tools/mkhook.py overlay --at $(AT) --bin $(FW_BIN) --base $(FW_BASE)
	@echo
	@echo "ВНИМАНИЕ: сам по себе этот патч НЕПОЛНЫЙ. Переход ведёт в область,"
	@echo "которой в вендорском образе нет. Образ пригоден только вместе с"
	@echo "записью, содержащей build/ext.bin."

# ---- сборка прошиваемого образа --------------------------------
# Вендорский .fw + наш код отдельной записью + все патчи хуков из build/*.ovl.
# IMAGE_IN задаёт исходный вендорский образ.
IMAGE_IN ?= ../images/vendor/fw/wil6210_4.1.0.1000.fw
IMAGE_OUT ?= $(BUILD)/wil6210-ext.fw

image: ext
	@test -f "$(IMAGE_IN)" || { echo "нет вендорского образа: $(IMAGE_IN)"; \
	  echo "укажи свой: make image IMAGE_IN=путь.fw"; exit 1; }
	python3 tools/mkimage.py --in $(IMAGE_IN) --out $(IMAGE_OUT) \
	  --add $(BUILD)/ext.bin@$(shell $(OBJDUMP) -h $(BUILD)/ext.elf | awk '/\.text\.ext/{print "0x"$$4}') \
	  $(addprefix --overlay ,$(wildcard $(BUILD)/*.ovl)) --strip

# ---- полная пересборка прошивки из собственного дерева ----------------
# src/asm/{fw,uc} — по файлу на функцию, получены из дизассемблированного
# образа и заменяются на C/C++ по мере декомпиляции.  src/data — таблицы.
# Инвариант: собранный образ побайтово равен вендорскому, пока ни один файл
# не переписан.  Он же и есть критерий правильности переписывания.

# Дополнительные -D для нашего кода, например:
#   make fw DEFS=-DLOG_BEACON_KIND=1
DEFS      ?=
# Трамплины милли-кода берём у самого gcc: вендорские в образе есть, но
# соглашение у них другое (см. config.mk), а эти — ровно те, под которые
# компилятор генерирует вызовы. Линковщик вытащит только нужные.
LIBGCC    := $(shell $(CC) -mcpu=$(ARC_CPU) -print-libgcc-file-name)

KIT       := ../blobs/kit-4100
STOCK_FW  := ../images/openwrt/fw/wil6210_4.1.0.1000.fw
INSNS     := ../blobs/insns/INSNS-4100.txt
FW_VER    := 4.1.0.1000

# адреса милли-кода ARC под именами, которыми его зовёт gcc
millicode:
	python3 tools/gen_millicode_ld.py --insns $(INSNS) --lo 0x8c0280 --hi 0x8c0380 \
	  --out ld/millicode-fw.ld
	python3 tools/gen_millicode_ld.py --insns $(INSNS) --lo 0x920180 --hi 0x9202d0 \
	  --out ld/millicode-uc.ld

# улики по каждому блоку: кто зовёт, кого зовёт, что печатает
anno:
	python3 tools/gen_annotations.py --insns $(INSNS) --blocks src/asm/fw/blocks.json \
	  --strings $(REF)/strings-fw.bin --gp 0x800170 --out $(REF)/ANNO-fw.json
	python3 tools/gen_annotations.py --insns $(INSNS) --blocks src/asm/uc/blocks.json \
	  --strings $(REF)/strings-uc.bin --gp 0x800528 --out $(REF)/ANNO-uc.json

# пересоздать дерево исходников из дизассемблированного образа
tree: anno millicode
	python3 tools/gen_asm_tree.py --insns $(INSNS) --syms $(REF)/SYMS.txt \
	  --bin $(KIT)/seg_008c0000.bin --base 0x8c0000 --region fw_code \
	  --raw $(REF)/RAW-fw.txt --anno $(REF)/ANNO-fw.json --names-extra $(REF)/NAMES-EXTRA.txt --filemap $(REF)/FN-FILEMAP.txt \
	  --outdir src/asm/fw --ld ld/image-fw.ld
	python3 tools/gen_asm_tree.py --insns $(INSNS) --syms $(REF)/SYMS.txt \
	  --bin $(KIT)/seg_00920000.bin --base 0x920000 --region uc_code \
	  --raw $(REF)/RAW-uc.txt --anno $(REF)/ANNO-uc.json --names-extra $(REF)/NAMES-EXTRA.txt --filemap $(REF)/FN-FILEMAP.txt \
	  --outdir src/asm/uc --ld ld/image-uc.ld
	python3 tools/gen_data_tree.py --kit $(KIT) --image $(STOCK_FW) \
	  --syms $(REF)/SYMS.txt --fw-blocks src/asm/fw/blocks.json \
	  --uc-blocks src/asm/uc/blocks.json \
	  --globals-fw $(REF)/GLOBALS-fw.txt --globals-uc $(REF)/GLOBALS-uc.txt --outdir src/data --ld ld/place-data.ld

# $(1) — fw или uc.  Блоки, для которых есть src/c/$(1)/имя.c, из
# ассемблерного дерева исключаются и собираются компилятором.
DATABIN_fw  := $(KIT)/seg_00900000.bin
DATABIN_uc  := $(KIT)/seg_00940000.bin
SEG_fw      := $(KIT)/seg_008c0000.bin
SEG_uc      := $(KIT)/seg_00920000.bin
DATASEC_fw  := fw_data
DATASEC_uc  := uc_data
POOL_fw     := 0x008f3b58
POOL_END_fw := 0x00900000
POOL_uc     := 0x009380c4
POOL_END_uc := 0x00940000

define build_seg
	@python3 tools/gen_layout.py --blocks src/asm/$(1)/blocks.json \
	  --csrc src/c/$(1) --pool $(POOL_$(1)) --pool-end $(POOL_END_$(1)) \
	  --data-sec $(DATASEC_$(1)) --data-addr 0x00800000 \
	  --bin $(SEG_$(1)) --data-bin $(DATABIN_$(1)) --fill-out src/asm/$(1)/vacated.s --out ld/image-$(1).ld
	@rm -rf $(BUILD)/$(1) && mkdir -p $(BUILD)/$(1)
	@find src/asm/$(1) -name "*.S" | grep -vFf <(cd src/c/$(1) 2>/dev/null && ls | sed 's/\.[^.]*$$//;s|^|/|;s|$$|.S|' || echo /@@нет@@) \
	  | xargs -P $$(nproc) -I@ sh -c '$(AS) -mcpu=$(ARC_CPU) -o $(BUILD)/$(1)/$$(basename @ .S).o @'
	@for f in $$(ls src/c/$(1)/*.S 2>/dev/null); do echo "  asm: $$f"; \
	   $(AS) -mcpu=$(ARC_CPU) -o $(BUILD)/$(1)/$$(basename $$f .S).o $$f || exit 1; done
	@for f in $$(ls src/c/$(1)/*.c 2>/dev/null); do echo "  C:   $$f"; \
	   $(CC) $(CFLAGS) $(DEFS) -Isrc/include -c -o $(BUILD)/$(1)/$$(basename $$f .c).o $$f || exit 1; done
	@for f in $$(ls src/c/$(1)/*.cpp 2>/dev/null); do echo "  C++: $$f"; \
	   $(CXX) $(CXXFLAGS) $(DEFS) -c -o $(BUILD)/$(1)/$$(basename $$f .cpp).o $$f || exit 1; done
	@test -s src/asm/$(1)/vacated.s && $(AS) -mcpu=$(ARC_CPU) \
	  -o $(BUILD)/$(1)/vacated.o src/asm/$(1)/vacated.s || true
	@$(AS) -mcpu=$(ARC_CPU) -o $(BUILD)/$(1)/$(DATASEC_$(1)).o src/data/$(DATASEC_$(1)).S
	@$(LD) -T ld/image-$(1).ld -o $(BUILD)/$(1).elf $(BUILD)/$(1)/*.o $(LIBGCC)
	@$(OBJCOPY) -O binary --gap-fill 0 -R .rodata.$(DATASEC_$(1)) $(BUILD)/$(1).elf $(BUILD)/$(1).bin
	@$(OBJCOPY) -O binary -j .rodata.$(DATASEC_$(1)) $(BUILD)/$(1).elf $(BUILD)/$(DATASEC_$(1)).bin
endef

define build_data
	@$(AS) -mcpu=$(ARC_CPU) -o $(BUILD)/$(1).o src/data/$(1).S
	@$(OBJCOPY) -O binary -j .rodata.$(1) $(BUILD)/$(1).o $(BUILD)/$(1).bin
endef

# собрать оба сегмента кода и сверить с вендорскими побайтово
rebuild: toolchain-check
	$(call build_seg,fw)
	$(call build_seg,uc)
	@python3 tools/cmp_seg.py $(BUILD)/fw.bin $(KIT)/seg_008c0000.bin fw_code
	@python3 tools/cmp_seg.py $(BUILD)/uc.bin $(KIT)/seg_00920000.bin uc_code

# собрать прошиваемый образ целиком из своего дерева
fw: rebuild
	$(call build_data,agc_tbl_004)
	$(call build_data,agc_tbl_208)
	$(call build_data,agc_tbl_608)
	@$(AS) -mcpu=$(ARC_CPU) -o $(BUILD)/direct_write.o src/data/direct_write.S
	@$(OBJCOPY) -O binary -j .rodata.direct_write $(BUILD)/direct_write.o $(BUILD)/direct_write.bin
	python3 tools/mkfw.py --version $(FW_VER) --out $(BUILD)/wil6210-selfbuilt.fw \
	  --rec data:0x008c0000=$(BUILD)/fw.bin \
	  --rec data:0x00900000=$(BUILD)/fw_data.bin \
	  --rec data:0x00920000=$(BUILD)/uc.bin \
	  --rec data:0x00940000=$(BUILD)/uc_data.bin \
	  --rec dw:$(BUILD)/direct_write.bin \
	  --rec data:0x0088a208=$(BUILD)/agc_tbl_208.bin \
	  --rec data:0x0088a608=$(BUILD)/agc_tbl_608.bin \
	  --rec data:0x0088a004=$(BUILD)/agc_tbl_004.bin \
	  --rec comment:badccdab0f100000 \
	  $$(find src/c \( -name '*.c' -o -name '*.cpp' -o -name '*.S' \) | grep -q . \
	     || echo --verify-against $(STOCK_FW))
	@find src/c \( -name '*.c' -o -name '*.cpp' -o -name '*.S' \) | grep -q . && echo \
	  "в образе есть переписанные блоки — побайтовая сверка не применима" || true

clean:
	rm -rf $(BUILD)/* 
