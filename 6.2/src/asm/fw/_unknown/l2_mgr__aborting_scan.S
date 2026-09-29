/* l2_mgr__aborting_scan @ 0x8c1da4, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::aborting_scan()
 *   l2_mgr::aborting_scan() failed, non-existent devid %d
 *   l2_mgr::aborting_scan() rejected, other scan is ongoing
 * Зовут его: wmi_abort_scan
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_log_emit1, mid_list__by_mid_fw, scan_abort
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__aborting_scan
l2_mgr__aborting_scan:
	.global L_8c1da4
L_8c1da4:
	push_s blink
L_8c1da6:
	bl L_8c01e4
L_8c1daa:
	bl.d L_8cc3dc
L_8c1dae:
	mov_s r14,r0
L_8c1db0:
	mov_s r13,r0
L_8c1db2:
	mov_s r1,0x100f230
L_8c1db8:
	bl.d L_8dcba8
L_8c1dbc:
	mov_s r0,0x29
L_8c1dbe:
	brne_s r13,0,L_8c1dd2
L_8c1dc0:
	mov_s r1,0x100f248
L_8c1dc6:
	mov_s r0,0x29
L_8c1dc8:
	bl.d L_8dcc10
L_8c1dcc:
	mov_s r2,r14
L_8c1dce:
	mov_s r0,0x0
L_8c1dd0:
	b_s L_8c1e02
	.global L_8c1dd2
L_8c1dd2:
	mov_s r0,r13
L_8c1dd4:
	add r0,r0,0x234
L_8c1dd8:
	ld_s r2,[r0,0x8]
L_8c1dda:
	ld_s r2,[r2,0x78]
L_8c1ddc:
	mov_s r1,0x0
L_8c1dde:
	brne_s r2,0,L_8c1de4
L_8c1de0:
	ld_s r2,[r0,0x4c]
L_8c1de2:
	breq_s r2,0,L_8c1de6
	.global L_8c1de4
L_8c1de4:
	mov_s r1,0x1
	.global L_8c1de6
L_8c1de6:
	extb.f 0x0,r1
L_8c1dea:
	bne_s L_8c1dfc
L_8c1dec:
	mov_s r1,0x100f280
L_8c1df2:
	bl.d L_8dcba8
L_8c1df6:
	mov_s r0,0x29
L_8c1df8:
	mov_s r0,0x0
L_8c1dfa:
	b_s L_8c1e02
	.global L_8c1dfc
L_8c1dfc:
	bl L_8f81fc
L_8c1e00:
	mov_s r0,0x1
	.global L_8c1e02
L_8c1e02:
	b L_8c0254
L_8c1e06:
	nop_s
