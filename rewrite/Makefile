# SPDX-License-Identifier: AGPL-3.0-or-later
# Перереализация прошивки wil6210 на C (C11) под ARC600.
#
# Цель — читаемый код с той же логикой, но собственным бинарным кодом.
# Никакой побайтовой сверки с вендором: собираем свой образ и отлаживаем его.

SHELL := /bin/bash

ARC_DIR  ?= $(abspath ../toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install)
ARC_BIN  ?= $(ARC_DIR)/bin
CROSS    ?= $(ARC_BIN)/arc-elf32-
ARC_CPU  ?= arc600

CC      = $(CROSS)gcc
LD      = $(CROSS)ld
OBJCOPY = $(CROSS)objcopy
OBJDUMP = $(CROSS)objdump

BUILD ?= build

# C11 (gnu11) — как договорились. -mno-sdata обязателен: gp мы ставим сами.
CFLAGS := -mcpu=$(ARC_CPU) -std=c11 -Os -ffreestanding -fno-builtin \
          -nostdlib -mno-sdata -ffunction-sections -fdata-sections -fno-common \
          -Wall -Wextra -Iinclude -MMD -MP
AFLAGS := -mcpu=$(ARC_CPU)
LDFLAGS := -nostdlib --gc-sections

FW_SRCS := $(wildcard fw/*.c)
FW_ASMS := $(wildcard fw/*.S)
FW_OBJS := $(patsubst %.c,$(BUILD)/%.o,$(FW_SRCS)) \
           $(patsubst %.S,$(BUILD)/%.o,$(FW_ASMS))

UC_SRCS := $(wildcard uc/*.c)
UC_ASMS := $(wildcard uc/*.S)
UC_OBJS := $(patsubst %.c,$(BUILD)/%.o,$(UC_SRCS)) \
           $(patsubst %.S,$(BUILD)/%.o,$(UC_ASMS))

all: $(BUILD)/fw.elf $(BUILD)/uc.elf

# uc: r25 — глобальный указатель кольца MAC-команд (как у vendor), компилятору не трогать
$(BUILD)/fw/%.o: CFLAGS += -include fw/proto.h -include fw/dccm.h -fno-strict-aliasing
$(BUILD)/fw/%.o: fw/proto.h fw/dccm.h
$(BUILD)/uc/%.o: CFLAGS += -ffixed-r25 -include uc/proto.h -include uc/dccm.h -Werror=implicit-function-declaration -fno-ipa-icf -mmul64 -fno-strict-aliasing
$(BUILD)/uc/%.o: uc/proto.h uc/dccm.h
# отладочные вставки uc (напр. UC_DBG=-DUC_DBG_SIFS); в рабочей сборке пусто
$(BUILD)/uc/%.o: CFLAGS += $(UC_DBG)
# uc/data.c определяет объекты с именами из dccm.h — там эти имена не макросы
$(BUILD)/uc/data.o: CFLAGS += -DUC_DCCM_OBJECTS
# uc/proto.h — tools/gen_uc_proto.py (перегенерировать при добавлении/смене сигнатур)

# Объекты зависят от заголовков (-MMD: *.d) и от самого Makefile (флаги)
$(BUILD)/%.o: %.c Makefile
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD)/%.o: %.S Makefile
	@mkdir -p $(dir $@)
	$(CC) $(AFLAGS) -MMD -MP -c -o $@ $<

-include $(FW_OBJS:.o=.d) $(UC_OBJS:.o=.d)

# fw/fw_data.c: начальный образ DCCM fw — так же, как uc/data.c (.fwdata.<адрес>). Объекты
# FWDATA вне fw_data.c (таблицы имён автоматов, регистрации конструкторов…) могут быть не
# нужны коду — -u для всех глобальных символов секций .fwdata.* держит их от --gc-sections.
# Второй -u держит от --gc-sections и объекты FWDATA в модулях, на которые код не
# ссылается (vendor-таблицы переходов switch и т. п.).
# -u удерживает от --gc-sections все глобальные объекты .fwdata.* (и в модулях: таблицы,
# на которые код не ссылается, — например таблицы переходов vendor — тоже часть образа).
FWDATA_LDFLAGS = $$(for o in $(FW_OBJS); do $(OBJDUMP) -h $$o; done | awk '$$2 ~ /^\.fwdata\./ {print "--section-start=" $$2 "=0x" substr($$2, 9)}' | sort -u) \
                 $$($(CROSS)nm $(BUILD)/fw/fw_data.o | awk '$$2 ~ /^[DdBb]$$/ {print "-u " $$3}') \
                 $$(for o in $(FW_OBJS); do $(OBJDUMP) -t $$o; done | awk '$$2 == "g" && $$4 ~ /^\.fwdata\./ {print "-u " $$NF}' | sort -u)
# (вторая строка: объекты FWDATA в модулях, на которые код не ссылается — таблицы имён
#  автоматов, регистрации конструкторов; на них ссылаются только числа в образе fw_data)

$(BUILD)/fw.elf: $(FW_OBJS) fw/fw.ld include/fwsh.h
	$(LD) $(LDFLAGS) -T fw/fw.ld $(FWDATA_LDFLAGS) -o $@ $(FW_OBJS) $(shell $(CC) -mcpu=$(ARC_CPU) -print-libgcc-file-name)
	python3 tools/check_fwsh.py $@ $(CROSS)nm

# uc/data.c: начальный образ DCCM. Объект в секции .ucdata.<адрес> ставится по этому
# адресу (--section-start), -u удерживает его от --gc-sections.
UCDATA_LDFLAGS = $$($(OBJDUMP) -h $(BUILD)/uc/data.o | awk '$$2 ~ /^\.ucdata\./ {print "--section-start=" $$2 "=0x" substr($$2, 9)}') \
                 $$($(CROSS)nm $(BUILD)/uc/data.o | awk '$$2 ~ /^[DdBb]$$/ {print "-u " $$3}')

$(BUILD)/uc.elf: $(UC_OBJS) uc/uc.ld
	$(LD) $(LDFLAGS) -T uc/uc.ld $(UCDATA_LDFLAGS) -o $@ $(UC_OBJS) $(shell $(CC) -mcpu=$(ARC_CPU) -print-libgcc-file-name)
	python3 tools/check_dccm.py $@ $(CROSS)nm

# Ошибка gas (binutils 2021.03 ARC): `neg.f 0,rX` кодируется с приёмником r0.
# Проверка: gcc не должен порождать эту форму ни в fw, ни в uc.
check-asm:
	@bad=0; for f in $(FW_SRCS) $(UC_SRCS); do \
	  x=""; case $$f in uc/*) x="-ffixed-r25";; esac; \
	  if $(CC) $(CFLAGS) $$x -S -o - $$f 2>/dev/null | grep -qE '\bneg(_s)?\.f[[:space:]]+0,'; then \
	    echo "ОШИБКА: $$f — neg.f 0,rX (gas закодирует приёмник r0)"; bad=1; fi; done; exit $$bad

# clean — только результаты компиляции; снимки/логи/дампы в build/ не трогаем
clean:
	rm -rf $(BUILD)/uc $(BUILD)/fw $(BUILD)/uc.elf $(BUILD)/fw.elf

.PHONY: all clean check-asm
