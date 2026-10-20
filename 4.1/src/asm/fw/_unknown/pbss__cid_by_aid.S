/* pbss__cid_by_aid @ 0x8c9da4, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Requested AID: %d
 *   Found CID %d with AID: %d
 *   Returning CID
 * Зовут его: pbss__del_sta
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit2, iter__has_more, iter__init, iter__next
 */
	.section .text.pbss__cid_by_aid,"ax",@progbits
	.global pbss__cid_by_aid
pbss__cid_by_aid:
	.global L_8c9da4
L_8c9da4:
	push_s blink
L_8c9da6:
	bl L_8c02c0
L_8c9daa:
	sub_s sp,sp,0x4
L_8c9dac:
	mov_s r15,r1
L_8c9dae:
	mov_s r14,sp
L_8c9db0:
	add r1,r0,0x18
L_8c9db4:
	bl.d L_8e1138
L_8c9db8:
	mov_s r0,r14
L_8c9dba:
	mov_s r2,0x100b9a8
L_8c9dc0:
	mov_s r0,0xb
L_8c9dc2:
	mov_s r1,0x2
L_8c9dc4:
	bl.d L_8edfcc
L_8c9dc8:
	mov_s r3,r15
L_8c9dca:
	b_s L_8c9dee
	.global L_8c9dcc
L_8c9dcc:
	bl.d L_8db188
L_8c9dd0:
	mov_s r0,r14
L_8c9dd2:
	mov_s r13,r0
L_8c9dd4:
	ldb r4,[r0, 0x9]
L_8c9dd8:
	mov_s r2,0x100b9bc
L_8c9dde:
	mov_s r0,0xb
L_8c9de0:
	mov_s r1,0x2
L_8c9de2:
	bl.d L_8edff8
L_8c9de6:
	ldb_s r3,[r13,0x8]
L_8c9de8:
	ldb_s r0,[r13,0x9]
L_8c9dea:
	breq r15,r0,L_8c9dfa
	.global L_8c9dee
L_8c9dee:
	bl.d L_8cb674
L_8c9df2:
	mov_s r0,r14
L_8c9df4:
	brne_s r0,0,L_8c9dcc
L_8c9df6:
	mov_s r13,0x0
L_8c9df8:
	b_s L_8c9e08
	.global L_8c9dfa
L_8c9dfa:
	mov_s r2,0x100b9d8
L_8c9e00:
	mov_s r0,0xb
L_8c9e02:
	bl.d L_8edfb0
L_8c9e06:
	mov_s r1,0x2
	.global L_8c9e08
L_8c9e08:
	mov_s r0,r13
L_8c9e0a:
	b.d L_8c032c
L_8c9e0e:
	add_s sp,sp,0x4
