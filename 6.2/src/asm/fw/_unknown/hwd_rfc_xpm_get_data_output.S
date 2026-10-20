/* hwd_rfc_xpm_get_data_output @ 0x8d44e4, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_xpm_get_data_output(): Timeout occured while waiting for valid data output. cur_iteration=%d, is_busy=%d, data_output_valid=%d,
 *   [NNL] rgf_val=0x%x
 * Зовут его: hwd_rfc_xpm_get_write_status, xpm__read_data_byte
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit1, fw_log_emit3, hwd_rfc_read_rgf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_xpm_get_data_output
hwd_rfc_xpm_get_data_output:
	.global L_8d44e4
L_8d44e4:
	push_s blink
L_8d44e6:
	bl L_8c01d0
L_8d44ea:
	mov_s r19,r0
L_8d44ec:
	mov_s r16,r1
L_8d44ee:
	mov_s r18,r2
L_8d44f0:
	mov_s r17,r3
L_8d44f2:
	mov_s r13,0x0
L_8d44f4:
	mov_s r14,r13
L_8d44f6:
	mov_s r4,r13
L_8d44f8:
	mov_s r3,r13
L_8d44fa:
	mov_s r15,r13
	.global L_8d44fc
L_8d44fc:
	breq r18,0x0,L_8d4504
L_8d4500:
	brlo r17,r14,L_8d4534
	.global L_8d4504
L_8d4504:
	mov_s r0,r19
L_8d4506:
	bl.d L_8d3588
L_8d450a:
	mov r1,0x3d0
L_8d450e:
	mov_s r13,r0
L_8d4510:
	mov_s r3,r0
L_8d4512:
	bic r3,r3,-0x401
L_8d4516:
	mov_s r4,r0
L_8d4518:
	bic r4,r4,-0x101
L_8d451c:
	mov_s r15,0x0
L_8d451e:
	bbit1 r0,0xa,L_8d4528
L_8d4522:
	btst_s r13,0x8
L_8d4524:
	mov.ne r15,0x1
	.global L_8d4528
L_8d4528:
	extb_s r15,r15
L_8d452a:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d452c:
	breq r18,0x0,L_8d4550
L_8d4530:
	breq_s r15,0,L_8d44fc
L_8d4532:
	b_s L_8d4550
	.global L_8d4534
L_8d4534:
	mov_s r1,0x101e8dc
L_8d453a:
	mov_s r0,0x0
L_8d453c:
	bl.d L_8dcd00
L_8d4540:
	mov_s r2,r14
L_8d4542:
	mov_s r1,0x101e964
L_8d4548:
	mov_s r0,0x0
L_8d454a:
	bl.d L_8dcc10
L_8d454e:
	mov_s r2,r13
	.global L_8d4550
L_8d4550:
	breq_s r15,0,L_8d4558
L_8d4552:
	stb r13,[r16]
L_8d4556:
	b_s L_8d455e
	.global L_8d4558
L_8d4558:
	mov_s r1,0xff
L_8d455a:
	stb r1,[r16]
	.global L_8d455e
L_8d455e:
	b.d L_8c022c
L_8d4562:
	mov_s r0,r15
