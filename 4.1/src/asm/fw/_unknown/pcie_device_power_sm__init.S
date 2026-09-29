/* pcie_device_power_sm__init @ 0x8d6050, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie_device_power_if__init
 * Зовёт сам: __ld_r13_ret, basic_sm__setup
 * Глобалы (через gp): 0x80019c
 */
	.section .text.pcie_device_power_sm__init,"ax",@progbits
	.global pcie_device_power_sm__init
pcie_device_power_sm__init:
	.global L_8d6050
L_8d6050:
	push_s blink
L_8d6052:
	push_s r13
L_8d6054:
	mov_s r13,r0
L_8d6056:
	mov r4,0x800a48
L_8d605e:
	mov r5,0x800a60
L_8d6066:
	ld.as r1,[gp,0xb]
L_8d606a:
	mov_s r2,0x0
L_8d606c:
	mov_s r3,0x801964
L_8d6072:
	mov r6,0x6
L_8d6076:
	bl.d L_8d6478
L_8d607a:
	mov r7,0x5
L_8d607e:
	mov_s r0,0x2
L_8d6080:
	b.d L_8c033c
L_8d6084:
	st_s r0,[r13,0x28]
L_8d6086:
	nop_s
