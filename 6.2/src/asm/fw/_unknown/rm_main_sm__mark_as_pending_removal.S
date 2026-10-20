/* rm_main_sm__mark_as_pending_removal @ 0x8ddcec, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::mark_as_pending_removal. Handle:0x%x
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__mark_as_pending_removal
rm_main_sm__mark_as_pending_removal:
	.global L_8ddcec
L_8ddcec:
	push_s blink
L_8ddcee:
	bl L_8c01e4
L_8ddcf2:
	mov_s r13,r0
L_8ddcf4:
	ldb_s r0,[r0,0x3]
L_8ddcf6:
	mov_s r14,r1
L_8ddcf8:
	breq_s r0,0,L_8ddd08
L_8ddcfa:
	mov_s r1,0x10192f0
L_8ddd00:
	mov_s r0,0x28
L_8ddd02:
	bl.d L_8dcc10
L_8ddd06:
	mov_s r2,r14
	.global L_8ddd08
L_8ddd08:
	ld_s r0,[r14,0x4]
L_8ddd0a:
	add_s r13,r13,0x7c
L_8ddd0c:
	cmp_s r13,r0
L_8ddd0e:
	mov_s r0,0x1
L_8ddd10:
	sub_s.ne r0,r0,r0
L_8ddd12:
	extb.f 0x0,r0
L_8ddd16:
	beq_s L_8ddd1e
L_8ddd18:
	mov_s r0,0x4
L_8ddd1a:
	st_s r0,[r14,0x8]
L_8ddd1c:
	b_s L_8ddd2a
	.global L_8ddd1e
L_8ddd1e:
	mov_s r0,blink
L_8ddd20:
	mov_s r1,0x1176
L_8ddd26:
	bl L_8c9b28
	.global L_8ddd2a
L_8ddd2a:
	b L_8c0254
L_8ddd2e:
	nop_s
