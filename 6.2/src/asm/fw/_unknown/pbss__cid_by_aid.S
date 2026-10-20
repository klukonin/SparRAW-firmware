/* pbss__cid_by_aid @ 0x8cbf64, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Requested AID: %d
 *   Found CID %d with AID: %d
 *   Returning CID
 * Зовут его: pbss__del_sta
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit2, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pbss__cid_by_aid
pbss__cid_by_aid:
	.global L_8cbf64
L_8cbf64:
	push_s blink
L_8cbf66:
	bl L_8c01e0
L_8cbf6a:
	sub_s sp,sp,0x4
L_8cbf6c:
	mov_s r15,r1
L_8cbf6e:
	mov_s r14,sp
L_8cbf70:
	add r1,r0,0x18
L_8cbf74:
	bl.d L_8e5df4
L_8cbf78:
	mov_s r0,r14
L_8cbf7a:
	mov_s r1,0x100cec4
L_8cbf80:
	mov_s r0,0x2b
L_8cbf82:
	bl.d L_8dcc10
L_8cbf86:
	mov_s r2,r15
L_8cbf88:
	b_s L_8cbfa8
	.global L_8cbf8a
L_8cbf8a:
	bl.d L_8df438
L_8cbf8e:
	mov_s r0,r14
L_8cbf90:
	mov_s r13,r0
L_8cbf92:
	ldb_s r2,[r13,0x8]
L_8cbf94:
	mov_s r1,0x100ced8
L_8cbf9a:
	mov_s r0,0x2b
L_8cbf9c:
	bl.d L_8dcc80
L_8cbfa0:
	ldb_s r3,[r13,0x9]
L_8cbfa2:
	ldb_s r0,[r13,0x9]
L_8cbfa4:
	breq r15,r0,L_8cbfb4
	.global L_8cbfa8
L_8cbfa8:
	bl.d L_8cdcb8
L_8cbfac:
	mov_s r0,r14
L_8cbfae:
	brne_s r0,0,L_8cbf8a
L_8cbfb0:
	mov_s r13,0x0
L_8cbfb2:
	b_s L_8cbfc0
	.global L_8cbfb4
L_8cbfb4:
	mov_s r1,0x100cef4
L_8cbfba:
	bl.d L_8dcba8
L_8cbfbe:
	mov_s r0,0x2b
	.global L_8cbfc0
L_8cbfc0:
	mov_s r0,r13
L_8cbfc2:
	b.d L_8c024c
L_8cbfc6:
	add_s sp,sp,0x4
