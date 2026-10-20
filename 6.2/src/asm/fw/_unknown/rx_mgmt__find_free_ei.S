/* rx_mgmt__find_free_ei @ 0x8c3370, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_mgmt_prs__alloc_ei
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_mgmt__find_free_ei
rx_mgmt__find_free_ei:
	.global L_8c3370
L_8c3370:
	mov_s r3,0x0
L_8c3372:
	b_s L_8c3376
	.global L_8c3374
L_8c3374:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_8c3376
L_8c3376:
	brhs r3,0x5,L_8c3390
L_8c337a:
	mul64 r3,0xd4
L_8c337e:
	add r1,r0,mlo
L_8c3382:
	ld_s r2,[r1,0x8]
L_8c3384:
	brne_s r2,0,L_8c3374
L_8c3386:
	mov_s r2,0x1
L_8c3388:
	st_s r2,[r1,0x8]
L_8c338a:
	add_s r0,r0,0x8
L_8c338c:
	add_s r0,r0,mlo
L_8c338e:
	b_s L_8c3392
	.global L_8c3390
L_8c3390:
	mov_s r0,0x0
	.global L_8c3392
L_8c3392:
	j_s [blink]
