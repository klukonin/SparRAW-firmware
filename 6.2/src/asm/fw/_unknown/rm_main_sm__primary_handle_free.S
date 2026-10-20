/* rm_main_sm__primary_handle_free @ 0x8e0e58, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::primary_handle_free. Handle:0x%x, CB 0x%x
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit2, radio_mgr__free_handle, sm__defer_call, tx_list__remove
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__primary_handle_free
rm_main_sm__primary_handle_free:
	.global L_8e0e58
L_8e0e58:
	push_s blink
L_8e0e5a:
	bl L_8c01e0
L_8e0e5e:
	mov_s r13,r0
L_8e0e60:
	ldb_s r0,[r0,0x3]
L_8e0e62:
	mov_s r14,r1
L_8e0e64:
	breq_s r0,0,L_8e0e76
L_8e0e66:
	mov_s r1,0x10192b8
L_8e0e6c:
	mov_s r0,0x28
L_8e0e6e:
	mov_s r2,r14
L_8e0e70:
	bl.d L_8dcc80
L_8e0e74:
	ld_s r3,[r14,0xc]
	.global L_8e0e76
L_8e0e76:
	add2 r15,r13,0x1f
L_8e0e7a:
	mov_s r0,r15
L_8e0e7c:
	bl.d L_8e2884
L_8e0e80:
	mov_s r1,r14
L_8e0e82:
	ld_s r0,[r13,0xc]
L_8e0e84:
	bl.d L_8ddb0c
L_8e0e88:
	mov_s r1,r14
L_8e0e8a:
	ld_s r0,[r15]
L_8e0e8c:
	cmp_s r0,0x0
L_8e0e8e:
	mov_s r0,0x1
L_8e0e90:
	sub_s.ne r0,r0,r0
L_8e0e92:
	extb.f 0x0,r0
L_8e0e96:
	mov.ne r0,r13
L_8e0e9a:
	mov.ne r1,0x5
L_8e0e9e:
	sub_s.ne r2,r2,r2
L_8e0ea0:
	mov.ne r3,r2
L_8e0ea4:
	bl.ne.d L_8e7044
L_8e0ea8:
	mov.ne r4,r2
L_8e0eac:
	b L_8c024c
