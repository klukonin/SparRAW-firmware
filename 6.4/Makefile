# SPDX-License-Identifier: AGPL-3.0-or-later
SHELL := /bin/bash
# Прошивка 6.4 — открытая прошивка на основе вендорской 6.2.0.1000.
#
# Основа — дерево 6.2 (../6.2/src/asm, ../6.2/src/data): оно не меняется и
# собирается в вендорский образ побайтово.  Здесь только наше: код на C/C++
# (src/c), заголовки и строки журнала (src/include, src/strings), правки
# дерева патчами quilt (patches/) и состав вариантов (variants/).
#
# Сборка копирует дерево 6.2 в build/tree, накладывает на копию серию патчей
# варианта, компилирует код и собирает образ:
#   make fw VARIANT=apsta      → build/wil6210-6.4-apsta.fw
#   make fw VARIANT=mesh       → build/wil6210-6.4-mesh.fw
#   make fw VARIANT=fix        → build/wil6210-6.2-fix.fw (вендорская 6.2 +
#                                только исправления ошибок, variants/fix.txt)
BASE  := ../6.2
include $(BASE)/config.mk

BUILD := build
REF   := $(BASE)/ref
TOOLS := $(BASE)/tools
TREE  := $(BUILD)/tree

KIT       := ../blobs/kit-6200
LIBGCC    := $(shell $(CC) -mcpu=$(ARC_CPU) -print-libgcc-file-name)

# Вариант (из-за места — две разные прошивки): apsta — режимы AP, STA и
# PBSS, приоритет надёжность; mesh — только DMG IBSS.  Состав — всё, кроме
# перечисленного в variants/<вариант>.txt.  fix — не 6.4, а вендорская 6.2
# с исправлениями ошибок: только перечисленное в variants/fix.txt.
VARIANT   ?= apsta
CDIR      := $(BUILD)/cdir-$(VARIANT)
SERIES    := series-$(VARIANT)
DEFS      ?=
DEFS      += -DFW64_$(shell echo $(VARIANT) | tr a-z A-Z)

# Строка версии (драйвер берёт 20 символов после «FW version: ») и автор —
# отдельной записью-комментарием образа.
FW_VER_fix := 6.2.0.1000-fix-EWM
FW_VER     = $(or $(FW_VER_$(VARIANT)),6.4.0.1-$(VARIANT)-EWM)
OUR_AUTHOR := klukonin (Evil Wireless Man)
# Возможности образа (запись-комментарий: магия 0xabcddcba, маска LE).  Бит 28
# (SparRAW) — переассоциация на месте (apsta, WMI 0x85b).
FW_CAPS_apsta := 5f300010
FW_CAPS_mesh  := 5f300000
FW_CAPS_fix   := 5f300000
FW_CAPS    = $(FW_CAPS_$(VARIANT))
FW_OUT_fix := $(BUILD)/wil6210-6.2-fix.fw
FW_OUT     = $(or $(FW_OUT_$(VARIANT)),$(BUILD)/wil6210-6.4-$(VARIANT).fw)

# Раскладка памяти и точки входа — как в 6.2 (../6.2/Makefile).
DATASEC_fw  := fw_data
DATASEC_uc  := uc_data
POOL_fw     := 0x008fc564
POOL_END_fw := 0x00900000
POOL_uc     := 0x0093ecc4
POOL_END_uc := 0x00940000
# Неиспользуемая область внутри fw_code (хвост нулей за вектором 19): код с
# FW_TEXT_GAP; слоты по 16 Б — точки входа таблицы переходов диспетчера WMI.
GAP_ARGS_fw := --gap-block fw_vector_19__unused_zero_fill --gap-start 0x008edd18
GAP_ARGS_uc :=
SLOTS_fw    := --slot wmi_branch_0x859=0x008edd18 --slot wmi_branch_0x85a=0x008edd28 --slot wmi_branch_0x85b=0x008edd38
SLOTS_uc    :=

.PHONY: all tree variant rebuild fw release clean

all:
	@echo "цели: fw (VARIANT=apsta|mesh) | release | tree | clean   (см. README.md)"

# состав варианта: C-блоки в $(CDIR), серия патчей patches/$(SERIES)
variant:
	@python3 $(TOOLS)/variant.py --list variants/$(VARIANT).txt --csrc src/c --out $(CDIR) \
	  --series patches/series --series-out patches/$(SERIES)

# копия дерева 6.2 с наложенной серией патчей варианта
tree: variant
	@rm -rf $(TREE) && mkdir -p $(TREE)/src
	@cp -a $(BASE)/src/asm $(BASE)/src/data $(TREE)/src/
	@cd $(TREE) && QUILT_PATCHES=$(CURDIR)/patches QUILT_SERIES=$(SERIES) \
	  quilt push -a -q >/dev/null || { echo "серия $(SERIES) не накладывается"; exit 1; }
	@echo "дерево: 6.2 + $$(grep -c . patches/$(SERIES)) патчей ($(VARIANT))"

# $(1) — fw или uc
define build_seg
	@rm -rf $(BUILD)/$(1) && mkdir -p $(BUILD)/$(1) $(BUILD)/gen
	@test ! -f src/strings/$(1).txt || python3 $(TOOLS)/gen_strings.py --vendor $(REF)/strings-$(1).bin \
	  --list src/strings/$(1).txt --out-bin $(BUILD)/strings-$(1).bin --out-h $(BUILD)/gen/strings-$(1).h
	@for f in $$(ls $(CDIR)/$(1)/*.c 2>/dev/null); do echo "  C:   $$f"; \
	   $(CC) $(CFLAGS) $(DEFS) -Isrc/include -I$(BUILD)/gen -c -o $(BUILD)/$(1)/$$(basename $$f .c).o $$f || exit 1; done
	@for f in $$(ls $(CDIR)/$(1)/*.cpp 2>/dev/null); do echo "  C++: $$f"; \
	   $(CXX) $(CXXFLAGS) $(DEFS) -I$(BUILD)/gen -c -o $(BUILD)/$(1)/$$(basename $$f .cpp).o $$f || exit 1; done
	@for f in $$(ls $(CDIR)/$(1)/new/*.cpp 2>/dev/null); do echo "  C++: $$f (новая)"; \
	   $(CXX) $(CXXFLAGS) $(DEFS) -I$(BUILD)/gen -c -o $(BUILD)/$(1)/new_$$(basename $$f .cpp).o $$f || exit 1; done
	@python3 $(TOOLS)/c_stubs.py --all $(TREE)/src/asm/$(1)/_all.S --blocks $(TREE)/src/asm/$(1)/blocks.json \
	  --csrc $(CDIR)/$(1) --relocs $(REF)/RELOCS-OK-$(1).txt $(GAP_ARGS_$(1)) \
	  --objdir $(BUILD)/$(1) --objdump $(OBJDUMP) --place-out $(BUILD)/$(1)/place.json \
	  --out $(BUILD)/$(1)/_all.S
	@python3 $(TOOLS)/gen_layout.py --blocks $(TREE)/src/asm/$(1)/blocks.json --plain \
	  --pool $(POOL_$(1)) --pool-end $(POOL_END_$(1)) --place $(BUILD)/$(1)/place.json $(SLOTS_$(1)) \
	  --data-sec $(DATASEC_$(1)) --data-addr 0x00800000 --out $(BUILD)/image-$(1).ld
	@$(AS) -mcpu=$(ARC_CPU) -I $(TREE)/src/asm/$(1) -o $(BUILD)/$(1)/code.o $(BUILD)/$(1)/_all.S
	@$(AS) -mcpu=$(ARC_CPU) -o $(BUILD)/$(1)/$(DATASEC_$(1)).o $(TREE)/src/data/$(DATASEC_$(1)).S
	@$(LD) -T $(BUILD)/image-$(1).ld -o $(BUILD)/$(1).elf $(BUILD)/$(1)/*.o $(LIBGCC)
	@$(OBJCOPY) -O binary --gap-fill 0 -j .text $(BUILD)/$(1).elf $(BUILD)/$(1).bin
	@$(OBJCOPY) -O binary -j .rodata.$(DATASEC_$(1)) $(BUILD)/$(1).elf $(BUILD)/$(DATASEC_$(1)).bin
endef

define build_data
	@$(AS) -mcpu=$(ARC_CPU) -o $(BUILD)/$(1).o $(TREE)/src/data/$(1).S
	@$(OBJCOPY) -O binary -j .rodata.$(1) $(BUILD)/$(1).o $(BUILD)/$(1).bin
endef

rebuild: tree
	$(call build_seg,fw)
	$(call build_seg,uc)
	@python3 $(TOOLS)/cmp_seg.py $(BUILD)/fw.bin $(KIT)/seg_008c0000.bin fw_code
	@python3 $(TOOLS)/cmp_seg.py $(BUILD)/uc.bin $(KIT)/seg_00920000.bin uc_code

fw: rebuild
	$(call build_data,agc_tbl_004)
	$(call build_data,agc_tbl_208)
	$(call build_data,agc_tbl_608)
	@$(AS) -mcpu=$(ARC_CPU) -o $(BUILD)/direct_write.o $(TREE)/src/data/direct_write.S
	@$(OBJCOPY) -O binary -j .rodata.direct_write $(BUILD)/direct_write.o $(BUILD)/direct_write.bin
	python3 $(TOOLS)/mkfw.py --version $(FW_VER) --out $(FW_OUT) --author "$(OUR_AUTHOR)" \
	  --rec data:0x008c0000=$(BUILD)/fw.bin \
	  --rec data:0x00900000=$(BUILD)/fw_data.bin \
	  --rec data:0x00920000=$(BUILD)/uc.bin \
	  --rec data:0x00940000=$(BUILD)/uc_data.bin \
	  --rec dw:$(BUILD)/direct_write.bin \
	  --rec data:0x0088a208=$(BUILD)/agc_tbl_208.bin \
	  --rec data:0x0088a608=$(BUILD)/agc_tbl_608.bin \
	  --rec data:0x0088a004=$(BUILD)/agc_tbl_004.bin \
	  --rec comment:badccdab$(FW_CAPS)

# выпуск: оба варианта 6.4 в ../images/sparraw, 6.2-fix — в ../images/openwrt/fw
# рядом с вендорским 6.2 (образы, которые кладутся в репозиторий)
RELEASE_DIR := ../images/sparraw
FIX_DIR     := ../images/openwrt/fw
release:
	@for v in apsta mesh; do $(MAKE) --no-print-directory fw VARIANT=$$v || exit 1; \
	   cp $(BUILD)/wil6210-6.4-$$v.fw $(RELEASE_DIR)/; done
	@$(MAKE) --no-print-directory fw VARIANT=fix && cp $(BUILD)/wil6210-6.2-fix.fw $(FIX_DIR)/wil6210_6.2.0.1000-fix.fw
	@cd $(RELEASE_DIR) && sha256sum wil6210-6.4-*.fw
	@cd $(FIX_DIR) && sha256sum wil6210_6.2.0.1000-fix.fw

clean:
	rm -rf $(BUILD)
