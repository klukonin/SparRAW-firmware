/* hwd_phy__get_884100 @ 0x8d2ea0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib__acquire_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__get_884100
hwd_phy__get_884100:
	.global L_8d2ea0
L_8d2ea0:
	mov_s r2,0x884100
L_8d2ea6:
	ld_s r1,[r2,0x30]
L_8d2ea8:
	bmsk_s r1,r1,0x0
L_8d2eaa:
	stb_s r1,[r0]
L_8d2eac:
	ld_s r1,[r2,0x34]
L_8d2eae:
	stb_s r1,[r0,0x1]
L_8d2eb0:
	lsr_s r1,r1,0x8
L_8d2eb2:
	j_s.d [blink]
L_8d2eb4:
	stb_s r1,[r0,0x2]
L_8d2eb6:
	nop_s
