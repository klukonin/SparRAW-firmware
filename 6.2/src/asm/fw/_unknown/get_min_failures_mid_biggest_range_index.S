/* get_min_failures_mid_biggest_range_index @ 0x8f35a8, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   get_min_failures_mid_biggest_range_index: consecutive_min_failures_start_index: %d, consecutive_min_failures_end_index :%d
 * Зовут его: hwd_rfc_read_calibrate
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit2, rfc_read_calib_get_min_failures
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global get_min_failures_mid_biggest_range_index
get_min_failures_mid_biggest_range_index:
	.global L_8f35a8
L_8f35a8:
	push_s blink
L_8f35aa:
	bl L_8c01d8
L_8f35ae:
	mov_s r17,r0
L_8f35b0:
	bl.d L_8f8060
L_8f35b4:
	mov_s r13,0x0
L_8f35b6:
	cmp r0,-0x1
L_8f35ba:
	beq_s L_8f35f0
L_8f35bc:
	mov_s r1,r13
L_8f35be:
	mov_s r16,r13
L_8f35c0:
	mov_s r14,r13
L_8f35c2:
	mov_s r3,r13
L_8f35c4:
	mov_s r2,r13
L_8f35c6:
	b_s L_8f35e0
	.global L_8f35c8
L_8f35c8:
	cmp_s r3,0x0
L_8f35ca:
	mov.eq r2,r1
L_8f35ce:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8f35d0:
	cmp_s r13,r3
L_8f35d2:
	mov.cs r13,r3
L_8f35d6:
	mov.cs r16,r1
L_8f35da:
	mov.cs r14,r2
	.global L_8f35de
L_8f35de:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8f35e0
L_8f35e0:
	brhs r1,0xa,L_8f35f4
L_8f35e4:
	ld.as r15,[r17,r1]
L_8f35e8:
	breq r0,r15,L_8f35c8
L_8f35ec:
	mov_s r3,0x0
L_8f35ee:
	b_s L_8f35de
	.global L_8f35f0
L_8f35f0:
	mov_s r0,0xf
L_8f35f2:
	b_s L_8f360a
	.global L_8f35f4
L_8f35f4:
	mov_s r1,0x101ea64
L_8f35fa:
	mov_s r0,0x20
L_8f35fc:
	mov_s r2,r14
L_8f35fe:
	bl.d L_8dcc80
L_8f3602:
	mov_s r3,r16
L_8f3604:
	add r0,r16,r14
L_8f3608:
	lsr_s r0,r0
	.global L_8f360a
L_8f360a:
	b L_8c023c
L_8f360e:
	nop_s
