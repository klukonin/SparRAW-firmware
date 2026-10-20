/* hwd_phy__rx_postdist_force_dc_config @ 0x8d2728, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_postdist_force_dc_config
hwd_phy__rx_postdist_force_dc_config:
	.global L_8d2728
L_8d2728:
	brge r0,0x0,L_8d2732
L_8d272c:
	add_s r0,r0,0x10
L_8d272e:
	extb_s r0,r0
L_8d2730:
	b_s L_8d2734
	.global L_8d2732
L_8d2732:
	extb_s r0,r0
	.global L_8d2734
L_8d2734:
	brge r1,0x0,L_8d273e
L_8d2738:
	add_s r1,r1,0x10
L_8d273a:
	extb_s r1,r1
L_8d273c:
	b_s L_8d2740
	.global L_8d273e
L_8d273e:
	extb_s r1,r1
	.global L_8d2740
L_8d2740:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8d2742:
	add_s r1,r1,r0
L_8d2744:
	mov_s r2,0x883580
L_8d274a:
	ld_s r0,[r2,0x4]
L_8d274c:
	extb_s r1,r1
L_8d274e:
	bic r0,r0,0xff
L_8d2752:
	or_s r0,r0,r1
L_8d2754:
	st_s r0,[r2,0x4]
L_8d2756:
	j_s [blink]
