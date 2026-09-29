/* hwd_rfc_xpm_get_write_status @ 0x8d4564, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_xpm_get_write_status(): XPM bit programming failure detected. is_completed=%d, data_output=0x%x
 * Зовут его: hwf_rf_xpm_program_byte
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit2, hwd_rfc_xpm_get_data_output
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_xpm_get_write_status
hwd_rfc_xpm_get_write_status:
	.global L_8d4564
L_8d4564:
	push_s blink
L_8d4566:
	push_s r13
L_8d4568:
	mov.f r2,r1
L_8d456c:
	mov_s r1,0x0
L_8d456e:
	stb.a r1,[sp,-0x4]
L_8d4572:
	beq_s L_8d4584
L_8d4574:
	extb_s r0,r0
L_8d4576:
	mov_s r1,sp
L_8d4578:
	mov_s r3,0x7d
L_8d457a:
	bl.d L_8d44e4
L_8d457e:
	/* _asl_s r3,r3,0x5 */
	.byte 0x05,0xbb
L_8d4580:
	mov_s r2,r0
L_8d4582:
	b_s L_8d4598
	.global L_8d4584
L_8d4584:
	mov r0,0x640
L_8d4588:
	mov lp_count,r0
L_8d458c:
	nop_s
L_8d458e:
	lp L_8d4596
L_8d4592:
	nop_s
L_8d4594:
	nop_s
	.global L_8d4596
L_8d4596:
	mov_s r2,0x1
	.global L_8d4598
L_8d4598:
	mov_s r13,0x0
L_8d459a:
	breq_s r2,0,L_8d45a4
L_8d459c:
	ldb_s r0,[sp,0x0]
L_8d459e:
	cmp_s r0,0x0
L_8d45a0:
	mov.eq r13,0x1
	.global L_8d45a4
L_8d45a4:
	extb.f r13,r13
L_8d45a8:
	bne_s L_8d45b8
L_8d45aa:
	mov_s r1,0x101e978
L_8d45b0:
	mov_s r0,0x0
L_8d45b2:
	bl.d L_8dcc80
L_8d45b6:
	ldb_s r3,[sp,0x0]
	.global L_8d45b8
L_8d45b8:
	mov_s r0,r13
L_8d45ba:
	b.d L_8c025c
L_8d45be:
	add_s sp,sp,0x4
