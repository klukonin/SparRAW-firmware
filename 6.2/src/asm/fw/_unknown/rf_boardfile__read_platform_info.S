/* rf_boardfile__read_platform_info @ 0x8f3478, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *         BOARD FILE INFO:  RF = %d Platform = 0x%x revision = 0x%x
 * Зовут его: check_rf_boardfile, wmi_get_rf_status
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_boardfile__read_platform_info
rf_boardfile__read_platform_info:
	.global L_8f3478
L_8f3478:
	push_s blink
L_8f347a:
	bl.d L_8c01d4
L_8f347e:
	mov_s r0,0x11
L_8f3480:
	mov_s r14,r1
L_8f3482:
	mov_s r13,r2
L_8f3484:
	mov_s r15,r3
L_8f3486:
	asl_s r0,r0,0x13
L_8f3488:
	ld_s r0,[r0,0x14]
L_8f348a:
	mov_s r1,0x1004fec
L_8f3490:
	lsr r16,r0,0x1c
L_8f3494:
	lsr r2,r0,0xc
L_8f3498:
	extw r17,r2
L_8f349c:
	bmsk r18,r0,0xb
L_8f34a0:
	mov_s r0,0x20
L_8f34a2:
	mov_s r2,r16
L_8f34a4:
	mov_s r3,r17
L_8f34a6:
	bl.d L_8dcd00
L_8f34aa:
	mov r4,r18
L_8f34ae:
	breq_s r14,0,L_8f34b4
L_8f34b0:
	st r16,[r14]
	.global L_8f34b4
L_8f34b4:
	breq_s r13,0,L_8f34ba
L_8f34b6:
	st r17,[r13]
	.global L_8f34ba
L_8f34ba:
	breq_s r15,0,L_8f34c0
L_8f34bc:
	st r18,[r15]
	.global L_8f34c0
L_8f34c0:
	b L_8c0234
