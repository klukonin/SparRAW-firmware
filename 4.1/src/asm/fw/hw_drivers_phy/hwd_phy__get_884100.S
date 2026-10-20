/* hwd_phy__get_884100 @ 0x8d00d8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib__acquire_hw
 */
	.section .text.hwd_phy__get_884100,"ax",@progbits
	.global hwd_phy__get_884100
hwd_phy__get_884100:
	.global L_8d00d8
L_8d00d8:
	mov_s r2,0x884100
L_8d00de:
	ld_s r1,[r2,0x30]
L_8d00e0:
	bmsk_s r1,r1,0x0
L_8d00e2:
	stb_s r1,[r0]
L_8d00e4:
	ld_s r1,[r2,0x34]
L_8d00e6:
	stb_s r1,[r0,0x1]
L_8d00e8:
	lsr_s r1,r1,0x8
L_8d00ea:
	j_s.d [blink]
L_8d00ec:
	stb_s r1,[r0,0x2]
L_8d00ee:
	nop_s
