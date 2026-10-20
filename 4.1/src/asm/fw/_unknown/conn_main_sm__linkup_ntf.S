/* conn_main_sm__linkup_ntf @ 0x8d7ca0, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_main_sm::linkup_ntf() status=%d, CID=%d.
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__store_pending_event, conn__store_linkup_field, fw_log__emit2, tail_lmac_if_send_cmd_0x04, u_schd__add
 */
	.section .text.conn_main_sm__linkup_ntf,"ax",@progbits
	.global conn_main_sm__linkup_ntf
conn_main_sm__linkup_ntf:
L_8d7ca0:
	push_s blink
L_8d7ca2:
	bl L_8c02c0
L_8d7ca6:
	mov_s r14,r0
L_8d7ca8:
	mov_s r15,r1
L_8d7caa:
	ld_s r0,[r0,0x2c]
L_8d7cac:
	mov_s r2,0x100f72c
L_8d7cb2:
	ldb r4,[r0, 0x8]
L_8d7cb6:
	mov_s r0,0xb
L_8d7cb8:
	mov_s r1,0x2
L_8d7cba:
	bl.d L_8edff8
L_8d7cbe:
	mov_s r3,r15
L_8d7cc0:
	mov_s r13,0x0
L_8d7cc2:
	st r13,[r14, 0x80]
L_8d7cc6:
	st_s r13,[r14,0x7c]
L_8d7cc8:
	bl.d L_8d8498
L_8d7ccc:
	mov_s r0,0x1
L_8d7cce:
	ld_s r0,[r14,0x2c]
L_8d7cd0:
	add_s r0,r0,0x64
L_8d7cd2:
	bl.d L_8e55cc
L_8d7cd6:
	mov_s r1,r13
L_8d7cd8:
	ld_s r0,[r14,0x2c]
L_8d7cda:
	brne_s r15,0,L_8d7cf8
L_8d7cdc:
	ld_s r0,[r0,0x18]
L_8d7cde:
	cmp_s r0,0x1
L_8d7ce0:
	mov.eq r0,r14
L_8d7ce4:
	mov.eq r1,0x3
L_8d7ce8:
	mov.eq r2,r13
L_8d7cec:
	mov.eq r3,r13
L_8d7cf0:
	bl.eq.d L_8e20c0
L_8d7cf4:
	mov.eq r4,r13
	.global L_8d7cf8
L_8d7cf8:
	mov_s r0,0x2da7c
L_8d7cfe:
	ld_s r1,[r14,0x2c]
L_8d7d00:
	mov_s r2,r15
L_8d7d02:
	bl.d L_8c2ac8
L_8d7d06:
	mov_s r3,0x1
L_8d7d08:
	b L_8c032c
