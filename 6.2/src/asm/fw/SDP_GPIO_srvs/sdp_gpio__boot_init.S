/* sdp_gpio__boot_init @ 0x8f8384, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 * Зовёт сам: SDP__sdp_init__2, __ld_r13_to_r13_ret, gpio__reset_config, hw_personality_detect, sdp_gpio__personality_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sdp_gpio__boot_init
sdp_gpio__boot_init:
	.global L_8f8384
L_8f8384:
	push_s blink
L_8f8386:
	bl.d L_8f4444
L_8f838a:
	push_s r13
L_8f838c:
	mov r0,0x320
L_8f8390:
	mov lp_count,r0
L_8f8394:
	nop_s
L_8f8396:
	lp L_8f839e
L_8f839a:
	nop_s
L_8f839c:
	nop_s
	.global L_8f839e
L_8f839e:
	bl.d L_8f84c0
L_8f83a2:
	mov_s r13,0x0
L_8f83a4:
	b_s L_8f83b8
	.global L_8f83a6
L_8f83a6:
	bl.d L_8f1920
L_8f83aa:
	mov_s r0,r13
L_8f83ac:
	cmp_s r0,0x0
L_8f83ae:
	bl.ne.d L_8f83c0
L_8f83b2:
	mov.ne r0,r13
L_8f83b6:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8f83b8
L_8f83b8:
	brlo r13,0x9,L_8f83a6
L_8f83bc:
	b L_8c025c
