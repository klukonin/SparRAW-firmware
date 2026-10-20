/* sta_ctx__reset @ 0x8e34e4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__on_start, calib_engine__step, link_stats__collect, lmac_if_link_lost_handler
 * Зовёт сам: __ld_r13_ret, memset0_words
 */
	.section .text.sta_ctx__reset,"ax",@progbits
	.global sta_ctx__reset
sta_ctx__reset:
	.global L_8e34e4
L_8e34e4:
	push_s blink
L_8e34e6:
	push_s r13
L_8e34e8:
	mov_s r1,0x855900
L_8e34ee:
	sub r1,r1,0x100
L_8e34f2:
	add2_s r1,r1,r0
L_8e34f4:
	ld.as r13,[r1,0x4e]
L_8e34f8:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8e34fa:
	add r2,r0,0x85580c
L_8e3502:
	ld_s r1,[r2,0x40]
L_8e3504:
	bl.d L_8c1a78
L_8e3508:
	mov_s r0,r13
L_8e350a:
	mov_s r0,0x886e80
L_8e3510:
	ld_s r0,[r0,0x38]
L_8e3512:
	st_s r0,[r13]
L_8e3514:
	b.d L_8c033c
L_8e3518:
	mov_s r0,r13
L_8e351a:
	nop_s
