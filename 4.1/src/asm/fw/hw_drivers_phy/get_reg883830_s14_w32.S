/* get_reg883830_s14_w32 @ 0x8cf8d8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy_monitor__task_step
 */
	.section .text.get_reg883830_s14_w32,"ax",@progbits
	.global get_reg883830_s14_w32
get_reg883830_s14_w32:
	.global L_8cf8d8
L_8cf8d8:
	mov_s r0,0x883800
L_8cf8de:
	ld_s r0,[r0,0x30]
L_8cf8e0:
	lsr_s r0,r0,0xe
L_8cf8e2:
	j_s.d [blink]
L_8cf8e4:
	bmsk_s r0,r0,0x6
L_8cf8e6:
	nop_s
