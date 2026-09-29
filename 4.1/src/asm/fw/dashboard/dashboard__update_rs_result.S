/* dashboard__update_rs_result @ 0x8e5970, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dashboard.cpp
 * Зовут его: lmac_if__rs_done_evt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_w_s24_w5, fw_sysassert_fatal, link_stats__calc_throughput_mbps
 */
	.section .text.dashboard__update_rs_result,"ax",@progbits
	.global dashboard__update_rs_result
dashboard__update_rs_result:
	.global L_8e5970
L_8e5970:
	push_s blink
L_8e5972:
	bl L_8c02c0
L_8e5976:
	mov_s r14,r0
L_8e5978:
	ldb_s r13,[r1,0x8]
L_8e597a:
	ldb_s r0,[r0]
L_8e597c:
	ldb_s r1,[r14,0x4]
L_8e597e:
	bl.d L_8c4a00
L_8e5982:
	ldb_s r2,[r14,0xd]
L_8e5984:
	asl_s r2,r13,0x4
L_8e5986:
	add3_s r2,r2,r2
L_8e5988:
	mov_s r15,0x854900
L_8e598e:
	add_s r2,r2,r15
L_8e5990:
	stw_s r0,[r2,0x4]
L_8e5992:
	ld_s r0,[r14,0x8]
L_8e5994:
	brne_s r0,0,L_8e59bc
L_8e5996:
	ld_s r0,[r2,0x78]
L_8e5998:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e599a:
	st_s r0,[r2,0x78]
L_8e599c:
	ldb_s r1,[r14,0xd]
L_8e599e:
	add_s r0,r2,0x4
L_8e59a0:
	bmsk_s r1,r1,0x4
L_8e59a2:
	bl L_8e8450
L_8e59a6:
	ldb_s r0,[r14,0xd]
L_8e59a8:
	brge r0,0xd,L_8e59c0
	.global L_8e59ac
L_8e59ac:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_8e59ae:
	ldb_s r0,[r14,0xd]
L_8e59b0:
	add3_s r13,r13,r13
L_8e59b2:
	add_s r13,r13,r15
L_8e59b4:
	add2_s r13,r13,r0
L_8e59b6:
	ld_s r0,[r13,0x18]
L_8e59b8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e59ba:
	st_s r0,[r13,0x18]
	.global L_8e59bc
L_8e59bc:
	b L_8c032c
	.global L_8e59c0
L_8e59c0:
	mov_s r0,blink
L_8e59c2:
	mov_s r2,0x1014c54
L_8e59c8:
	mov_s r1,0x1118
L_8e59ce:
	bl.d L_8c82c0
L_8e59d2:
	mov_s r3,0x64
L_8e59d4:
	b_s L_8e59ac
L_8e59d6:
	nop_s
