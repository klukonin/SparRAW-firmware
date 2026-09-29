/* conn_main_sm__bf_ntf @ 0x8c3f20, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_main_sm:: bf_ntf for CID %d with status %d.
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, tail_l2mgr__notify_link_up
 */
	.section .text.conn_main_sm__bf_ntf,"ax",@progbits
	.global conn_main_sm__bf_ntf
conn_main_sm__bf_ntf:
L_8c3f20:
	push_s blink
L_8c3f22:
	bl L_8c02c4
L_8c3f26:
	mov_s r13,r0
L_8c3f28:
	mov_s r14,r1
L_8c3f2a:
	ld_s r3,[r0,0x2c]
L_8c3f2c:
	mov_s r2,0x100f75c
L_8c3f32:
	ldb_s r3,[r3,0x8]
L_8c3f34:
	mov_s r0,0xb
L_8c3f36:
	mov_s r1,0x2
L_8c3f38:
	bl.d L_8edff8
L_8c3f3c:
	mov_s r4,r14
L_8c3f3e:
	ld_s r1,[r13,0x2c]
L_8c3f40:
	ld_s r0,[r1,0xc]
L_8c3f42:
	bl.d L_8d7bd4
L_8c3f46:
	mov_s r2,r14
L_8c3f48:
	b L_8c0334
