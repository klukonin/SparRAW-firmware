# SPDX-License-Identifier: AGPL-3.0-or-later
# Тулчейн ARC: распакованный пребилд Synopsys, по умолчанию ./toolchain в корне
# репозитория (tools/get-toolchain.sh); переопредели при необходимости.
ARC_DIR  ?= $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/../toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install)
ARC_BIN  ?= $(ARC_DIR)/bin
CROSS    ?= $(ARC_BIN)/arc-elf32-

# ВАЖНО: именно arc600. Прошивка использует mulu64 (расширение MUL64
# линейки ARC600); при -mcpu=arc700 ассемблер его отвергает.
ARC_CPU  ?= arc600

CC   = $(CROSS)gcc
AS   = $(CROSS)as
LD   = $(CROSS)ld
OBJCOPY = $(CROSS)objcopy
OBJDUMP = $(CROSS)objdump

CXX  = $(CROSS)g++
# Милли-код оставлен включённым (он и так по умолчанию при -Os), но
# трамплины берутся ИЗ LIBGCC, а не из прошивки — см. LIBGCC в Makefile.
# В образе свои такие подпрограммы есть, и раскладка регистров у них та же
# (r13 в [sp+0], r14 в [sp+4], r15 в [sp+8]), но соглашения расходятся в
# двух местах сразу:
#   * сохранение: трамплин gcc кладёт регистры по фиксированным смещениям и
#     sp НЕ трогает — кадр выделяет вызывающий; вендорская цепочка двигает
#     sp сама через st.aw. Связать их значит выделить кадр дважды;
#   * восстановление: gcc передаёт размер кадра в r12, вендорский трамплин
#     своё r12/r13 ставит сам и чужое затирает. Совпадение вышло бы только
#     для функций без локальных переменных на стеке — и сломалось бы молча
#     на первой же функции с ними.
#
# ВАЖНО: -mno-sdata обязателен. По умолчанию gcc адресует глобальные
# переменные через gp (ld_s r0,[gp,0]), а в прошивке gp — НАСТОЯЩИЙ
# глобальный указатель на её собственные данные (0x800170 в fw,
# 0x800528 в ucode, ставится один раз при старте). Наш код, собранный
# без этого флага, читал бы и писал чужую память.
# -ffixed-r25: в микрокоде r25 — глобальный указатель кольца команд MAC
# (2485 обращений). gcc об этом не знает: mac_cmd() правит r25 вставкой
# ассемблера, но в clobber-список его не заявляет, и при нехватке регистров
# компилятор свободно берёт r25 под переменную, сохраняя и ВОССТАНАВЛИВАЯ его
# в прологе/эпилоге — то есть молча откатывая указатель кольца. На нынешнем
# коде флаг не меняет ни одного байта (проверено), но закрывает единственный
# способ сломать кольцо незаметно.
CXXFLAGS ?= -mcpu=$(ARC_CPU) -Os -ffreestanding -fno-builtin -nostdlib -mno-sdata -ffixed-r25 \
           -ffunction-sections -fdata-sections -fno-common -fno-exceptions \
           -fno-rtti -fno-threadsafe-statics -fno-use-cxa-atexit -Wall \
           -Isrc/include
CFLAGS  ?= -mcpu=$(ARC_CPU) -Os -ffreestanding -fno-builtin -nostdlib -mno-sdata -ffixed-r25 \
           -ffunction-sections -fdata-sections -fno-common -Wall
ASFLAGS ?= -mcpu=$(ARC_CPU)
LDFLAGS ?= -nostdlib --gc-sections
