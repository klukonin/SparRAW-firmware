/* conn_main_sm__action_8c4898 @ 0x8c4898, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_main_sm:: bf_ntf for CID %d with status %d.
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn__notify_link_via_l2mgr, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__action_8c4898
conn_main_sm__action_8c4898:
	.global L_8c4898
L_8c4898:
	push_s blink
L_8c489a:
	bl L_8c01e4
L_8c489e:
	mov_s r13,r0
L_8c48a0:
	mov_s r14,r1
L_8c48a2:
	ld_s r2,[r0,0x8]
L_8c48a4:
	mov_s r1,0x1011a60
L_8c48aa:
	ldb_s r2,[r2,0x8]
L_8c48ac:
	mov_s r0,0x2b
L_8c48ae:
	bl.d L_8dcc80
L_8c48b2:
	mov_s r3,r14
L_8c48b4:
	ld_s r1,[r13,0x8]
L_8c48b6:
	ld_s r0,[r1,0x18]
L_8c48b8:
	bl.d L_8dace4
L_8c48bc:
	mov_s r2,r14
L_8c48be:
	b L_8c0254
L_8c48c2:
	nop_s
