/* l2mgr__send_scan_complete_evt @ 0x8e5a5c, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_ACS_PASSIVE_SCAN_COMPLETE_EVENTID dwell_time=%d, num_scan_channels=%d, res_type=%d
 * Зовут его: scan_mngr__scan_done
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit3, fw_sysassert_fatal, host_if__send_pair, l2mgr__pending_op_clear, low_sme__send_evt2sw, memcpy_fw, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_scan_complete_evt
l2mgr__send_scan_complete_evt:
	.global L_8e5a5c
L_8e5a5c:
	push_s blink
L_8e5a5e:
	bl L_8c01d4
L_8e5a62:
	sub_s sp,sp,0x3c
L_8e5a64:
	mov_s r15,r0
L_8e5a66:
	mov_s r18,r1
L_8e5a68:
	mov_s r16,r2
L_8e5a6a:
	mov_s r13,r3
L_8e5a6c:
	bl.d L_8c32d8
L_8e5a70:
	mov r17,r4
L_8e5a74:
	mov_s r14,r0
L_8e5a76:
	st r16,[r0]
L_8e5a7a:
	stb_s r13,[r0,0x6]
L_8e5a7c:
	mov_s r0,0x3
L_8e5a7e:
	stw_s r0,[r14,0x4]
L_8e5a80:
	stb_s r15,[r14,0x7]
L_8e5a82:
	mov_s r0,sp
L_8e5a84:
	bl.d L_8c1cd8
L_8e5a88:
	mov_s r1,0x3c
L_8e5a8a:
	mov_s r1,0x0
L_8e5a8c:
	mov_s r2,r1
L_8e5a8e:
	b_s L_8e5aae
	.global L_8e5a90
L_8e5a90:
	asl_s r0,r2,0x2
L_8e5a92:
	add1_s r0,r0,r0
L_8e5a94:
	ld.a r3,[r0,r17]
L_8e5a98:
	breq_s r3,0,L_8e5aac
L_8e5a9a:
	asl_s r3,r1,0x2
L_8e5a9c:
	add1_s r3,r3,r3
L_8e5a9e:
	add_s r3,r3,sp
L_8e5aa0:
	stb_s r2,[r3]
L_8e5aa2:
	ld_s r15,[r0,0x4]
L_8e5aa4:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e5aa6:
	stw_s r15,[r3,0x2]
L_8e5aa8:
	ld_s r0,[r0,0x8]
L_8e5aaa:
	stb_s r0,[r3,0x1]
	.global L_8e5aac
L_8e5aac:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_8e5aae
L_8e5aae:
	brlo r2,0x5,L_8e5a90
L_8e5ab2:
	brne r13,r1,L_8e5b08
	.global L_8e5ab6
L_8e5ab6:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8e5ab8:
	add1_s r13,r13,r13
L_8e5aba:
	extb_s r13,r13
L_8e5abc:
	add r0,r14,0x8
L_8e5ac0:
	mov_s r1,sp
L_8e5ac2:
	bl.d L_8c0380
L_8e5ac6:
	mov_s r2,r13
L_8e5ac8:
	ldw r4,[r14, 0x4]
L_8e5acc:
	mov_s r1,0x100eb68
L_8e5ad2:
	ld_s r2,[r14]
L_8e5ad4:
	mov_s r0,0x2b
L_8e5ad6:
	bl.d L_8dcd00
L_8e5ada:
	ldb_s r3,[r14,0x6]
L_8e5adc:
	add r2,r13,0x8
L_8e5ae0:
	extw_s r2,r2
L_8e5ae2:
	mov_s r0,r14
L_8e5ae4:
	mov_s r1,0x9005
L_8e5aea:
	mov_s r3,r18
L_8e5aec:
	mov r4,0x0
L_8e5af0:
	mov r5,r4
L_8e5af4:
	bl.d L_8e5474
L_8e5af8:
	mov r6,r4
L_8e5afc:
	bl.d L_8c6a30
L_8e5b00:
	mov_s r0,0x0
L_8e5b02:
	b.d L_8c0234
L_8e5b06:
	add_s sp,sp,0x3c
	.global L_8e5b08
L_8e5b08:
	mov_s r0,blink
L_8e5b0a:
	mov_s r1,0x4d
L_8e5b0c:
	/* bl.d 0x008c9b28 */
	.byte 0x1e,0x08,0x2f,0xf2
L_8e5b10:
	/* _asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8e5b12:
	b_s L_8e5ab6
