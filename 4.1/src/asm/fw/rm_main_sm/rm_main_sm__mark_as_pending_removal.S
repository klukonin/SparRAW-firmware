/* rm_main_sm__mark_as_pending_removal @ 0x8d9d9c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::mark_as_pending_removal. Handle:0x%x
 *   rm_main_sm.cpp
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.rm_main_sm__mark_as_pending_removal,"ax",@progbits
	.global rm_main_sm__mark_as_pending_removal
rm_main_sm__mark_as_pending_removal:
L_8d9d9c:
	push_s blink
L_8d9d9e:
	bl L_8c02c4
L_8d9da2:
	mov_s r13,r0
L_8d9da4:
	ld_s r0,[r0,0x28]
L_8d9da6:
	mov_s r14,r1
L_8d9da8:
	breq_s r0,0,L_8d9dba
L_8d9daa:
	mov_s r2,0x1015f90
L_8d9db0:
	mov_s r0,0x8
L_8d9db2:
	mov_s r1,0x2
L_8d9db4:
	bl.d L_8edfcc
L_8d9db8:
	mov_s r3,r14
	.global L_8d9dba
L_8d9dba:
	ld_s r0,[r14,0x4]
L_8d9dbc:
	add r13,r13,0xc4
L_8d9dc0:
	cmp_s r13,r0
L_8d9dc2:
	mov_s r0,0x1
L_8d9dc4:
	sub_s.ne r0,r0,r0
L_8d9dc6:
	extb.f 0x0,r0
L_8d9dca:
	beq_s L_8d9dd2
L_8d9dcc:
	mov_s r0,0x4
L_8d9dce:
	st_s r0,[r14,0x8]
L_8d9dd0:
	b_s L_8d9de8
	.global L_8d9dd2
L_8d9dd2:
	mov_s r0,blink
L_8d9dd4:
	mov_s r2,0x1015d54
L_8d9dda:
	mov_s r1,0x1176
L_8d9de0:
	bl.d L_8c82c0
L_8d9de4:
	mov r3,0x20e
	.global L_8d9de8
L_8d9de8:
	b L_8c0334
