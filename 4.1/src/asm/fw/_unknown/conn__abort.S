/* conn__abort @ 0x8e8dbc, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn::abort(): cid=%d
 * Зовут его: conn_mgr__link_down_evt, scan_mngr__prob_done
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__inject_event, conn__teardown_mac_rules, fw_log__emit1, lm_if__disable_link_loss_monitoring
 */
	.section .text.conn__abort,"ax",@progbits
	.global conn__abort
conn__abort:
	.global L_8e8dbc
L_8e8dbc:
	push_s blink
L_8e8dbe:
	bl L_8c02c0
L_8e8dc2:
	mov_s r13,r0
L_8e8dc4:
	mov_s r14,r1
L_8e8dc6:
	mov_s r2,0x100e2cc
L_8e8dcc:
	mov_s r0,0xb
L_8e8dce:
	mov_s r1,0x2
L_8e8dd0:
	bl.d L_8edfcc
L_8e8dd4:
	ldb_s r3,[r13,0x8]
L_8e8dd6:
	add2 r15,r13,0x3f
L_8e8dda:
	brne_s r14,0,L_8e8dfa
L_8e8ddc:
	bl.d L_8f10d8
L_8e8de0:
	mov_s r0,r13
L_8e8de2:
	mov_s r0,r15
L_8e8de4:
	mov_s r1,0xa
L_8e8de6:
	mov_s r2,0x0
L_8e8de8:
	mov_s r3,r2
L_8e8dea:
	bl.d L_8d6a1c
L_8e8dee:
	mov_s r4,r2
L_8e8df0:
	bl.d L_8c7950
L_8e8df4:
	add2 r0,r13,0x19
L_8e8df8:
	b_s L_8e8e08
	.global L_8e8dfa
L_8e8dfa:
	mov_s r0,r15
L_8e8dfc:
	mov_s r1,0xa
L_8e8dfe:
	mov_s r2,0x0
L_8e8e00:
	mov_s r3,r2
L_8e8e02:
	bl.d L_8d6a1c
L_8e8e06:
	mov_s r4,r2
	.global L_8e8e08
L_8e8e08:
	b L_8c032c
