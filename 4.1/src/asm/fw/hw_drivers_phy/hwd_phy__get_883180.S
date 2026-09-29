/* hwd_phy__get_883180 @ 0x8cf9f0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib__acquire_hw
 */
	.section .text.hwd_phy__get_883180,"ax",@progbits
	.global hwd_phy__get_883180
hwd_phy__get_883180:
	.global L_8cf9f0
L_8cf9f0:
	mov_s r0,0x883180
L_8cf9f6:
	ld_s r0,[r0,0x40]
L_8cf9f8:
	bmsk_s r0,r0,0x5
L_8cf9fa:
	cmp_s r0,0x21
L_8cf9fc:
	mov_s r0,0x1
L_8cf9fe:
	j_s.d [blink]
L_8cfa00:
	sub_s.ne r0,r0,r0
L_8cfa02:
	nop_s
