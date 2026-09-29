/* sta__apply_bf_result @ 0x921ca8, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_req__dequeue_head
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf__resume_sta_tx, rs__is_sta_enabled, rs_start, sta__reset_link_state, sta_link__byte_by_index, ucode_pm__set_busy_flag
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sta__apply_bf_result
sta__apply_bf_result:
	.global L_921ca8
L_921ca8:
	push_s blink
L_921caa:
	bl L_920230
L_921cae:
	mov_s r15,r0
L_921cb0:
	mov_s r14,r1
L_921cb2:
	asl_s r0,r14,0x2
L_921cb4:
	mov_s r1,0x857e49
L_921cba:
	add2_s r0,r0,r0
L_921cbc:
	ldb_s r13,[r1,r0]
L_921cbe:
	mov_s r0,r14
L_921cc0:
	bic r13,r13,-0x41
L_921cc4:
	cmp_s r13,0x0
L_921cc6:
	mov_s r13,0x1
L_921cc8:
	sub_s.ne r13,r13,r13
L_921cca:
	mov_s r1,0x1
L_921ccc:
	bl.d L_921900
L_921cd0:
	mov_s r2,r13
L_921cd2:
	brne r15,0x1,L_921d1e
L_921cd6:
	mov_s r1,0x8020fc
L_921cdc:
	ldb_s r0,[r1,0x15]
L_921cde:
	stw.as r0,[gp,-0x5d]
L_921ce2:
	ldb_s r0,[r1,0x14]
L_921ce4:
	mov_s r1,0x80114c
L_921cea:
	stw.as r0,[gp,-0x5e]
L_921cee:
	asl_s r0,r14,0x4
L_921cf0:
	add2_s r0,r0,r0
L_921cf2:
	ldb_s r0,[r1,r0]
L_921cf4:
	brne_s r0,0,L_921d4a
L_921cf6:
	breq_s r13,0,L_921d4a
L_921cf8:
	bl.d L_9300c0
L_921cfc:
	mov_s r0,r14
L_921cfe:
	mov_s r1,r0
L_921d00:
	bl.d L_9300ec
L_921d04:
	mov_s r0,r14
L_921d06:
	bl.d L_9300ac
L_921d0a:
	mov_s r0,r14
L_921d0c:
	breq_s r0,0,L_921d4a
L_921d0e:
	mov_s r0,0x3
L_921d10:
	bl.d L_92bb34
L_921d14:
	mov_s r1,r14
L_921d16:
	bl.d L_93c874
L_921d1a:
	mov_s r0,0x1
L_921d1c:
	b_s L_921d4a
	.global L_921d1e
L_921d1e:
	breq r14,0x8,L_921d4a
L_921d22:
	ld.as r2,[gp,-0x3]
L_921d26:
	ldw_s r0,[gp,-0xba]
L_921d28:
	bset r1,r2,0x5
L_921d2c:
	asl_s r0,r0,0x8
L_921d2e:
	or_s r0,r0,r1
L_921d30:
	/* asl_s r14,r14,0x4 */
	.byte 0x04,0xbe
L_921d32:
	add2_s r14,r14,r14
L_921d34:
	add_s r14,r14,0x801104
L_921d3a:
	st_s r0,[r14,0x4]
L_921d3c:
	ldw.as r1,[gp,-0x5e]
L_921d40:
	or r0,r2,0x30
L_921d44:
	asl_s r1,r1,0x8
L_921d46:
	or_s r0,r0,r1
L_921d48:
	st_s r0,[r14,0x8]
	.global L_921d4a
L_921d4a:
	b L_92029c
L_921d4e:
	nop_s
