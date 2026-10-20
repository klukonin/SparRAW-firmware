/* hwd_phy__get_883180 @ 0x8d26bc, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib__acquire_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__get_883180
hwd_phy__get_883180:
	.global L_8d26bc
L_8d26bc:
	mov_s r0,0x883180
L_8d26c2:
	ld_s r0,[r0,0x40]
L_8d26c4:
	bmsk_s r0,r0,0x5
L_8d26c6:
	cmp_s r0,0x21
L_8d26c8:
	mov_s r0,0x1
L_8d26ca:
	j_s.d [blink]
L_8d26cc:
	sub_s.ne r0,r0,r0
L_8d26ce:
	nop_s
