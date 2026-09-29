/* rm__channel_matches @ 0x8d7314, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__enter_primary_non_locked
 */
	.section .text.rm__channel_matches,"ax",@progbits
	.global rm__channel_matches
rm__channel_matches:
	.global L_8d7314
L_8d7314:
	push_s r13
L_8d7316:
	ld_s r13,[r0]
L_8d7318:
	ld_s r3,[r1]
L_8d731a:
	mov_s r2,0x0
L_8d731c:
	brne r13,r3,L_8d7328
L_8d7320:
	ld_s r13,[r0,0x4]
L_8d7322:
	ld_s r3,[r1,0x4]
L_8d7324:
	breq r13,r3,L_8d732c
	.global L_8d7328
L_8d7328:
	mov_s r0,r2
L_8d732a:
	b_s L_8d7336
	.global L_8d732c
L_8d732c:
	ld_s r3,[r0,0xc]
L_8d732e:
	ld_s r0,[r1,0xc]
L_8d7330:
	brne r3,r0,L_8d7328
L_8d7334:
	mov_s r0,0x1
	.global L_8d7336
L_8d7336:
	extb_s r0,r0
L_8d7338:
	j_s.d [blink]
L_8d733a:
	pop_s r13
