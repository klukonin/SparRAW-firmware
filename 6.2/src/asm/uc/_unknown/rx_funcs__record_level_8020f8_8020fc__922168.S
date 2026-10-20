/* rx_funcs__record_level_8020f8_8020fc__922168 @ 0x922168, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__handle_ppdu_report, sls__rx_ssw_frame
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_funcs__record_level_8020f8_8020fc__922168
rx_funcs__record_level_8020f8_8020fc__922168:
	.global L_922168
L_922168:
	/* asr_s r0,r0,0x2 */
	.byte 0x42,0xb8
L_92216a:
	add_s r0,r0,0x13
L_92216c:
	sexb_s r0,r0
L_92216e:
	mov_s r2,0x8020f0
L_922174:
	mov_s r1,0x80212c
L_92217a:
	ld_s r3,[r1,0x8]
L_92217c:
	stb_s r0,[r2,0xc]
L_92217e:
	sexb_s r1,r3
L_922180:
	stb_s r3,[r2,0xd]
L_922182:
	min r0,r1,r0
L_922186:
	j_s.d [blink]
L_922188:
	st_s r0,[r2,0x8]
L_92218a:
	nop_s
