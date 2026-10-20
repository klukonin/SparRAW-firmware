/* rx_funcs__record_level_800fa0 @ 0x922a10, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__handle_ppdu_report, rx_funcs__identify_peer
 */
	.section .text.rx_funcs__record_level_800fa0,"ax",@progbits
	.global rx_funcs__record_level_800fa0
rx_funcs__record_level_800fa0:
	.global L_922a10
L_922a10:
	/* asr_s r0,r0,0x2 */
	.byte 0x42,0xb8
L_922a12:
	add_s r0,r0,0x13
L_922a14:
	sexb_s r0,r0
L_922a16:
	mov_s r2,0x800fa0
L_922a1c:
	mov_s r1,0x800fcc
L_922a22:
	ld_s r3,[r1,0x8]
L_922a24:
	stb_s r0,[r2,0xc]
L_922a26:
	sexb_s r1,r3
L_922a28:
	stb_s r3,[r2,0xd]
L_922a2a:
	min r0,r1,r0
L_922a2e:
	j_s.d [blink]
L_922a30:
	st_s r0,[r2,0x8]
L_922a32:
	nop_s
