/* pcie_device_power_sm__init @ 0x8d9100, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie_device_power_if__init
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__bind_descriptor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_device_power_sm__init
pcie_device_power_sm__init:
	.global L_8d9100
L_8d9100:
	push_s blink
L_8d9102:
	push_s r13
L_8d9104:
	mov_s r1,0x801ca8
L_8d910a:
	bl.d L_8d94e0
L_8d910e:
	mov_s r13,r0
L_8d9110:
	mov_s r0,0x1
L_8d9112:
	b.d L_8c025c
L_8d9116:
	stb_s r0,[r13,0x3]
