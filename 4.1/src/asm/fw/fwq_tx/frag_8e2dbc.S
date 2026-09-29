/* frag_8e2dbc @ 0x8e2dbc, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwq_tx.cpp
 * Зовут его: tx_api__pause_for_ch_switch
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, fwq_tx__on_queue_empty
 */
	.section .text.frag_8e2dbc,"ax",@progbits
	.global frag_8e2dbc
frag_8e2dbc:
	.global L_8e2dbc
L_8e2dbc:
	push_s blink
L_8e2dbe:
	push_s r13
L_8e2dc0:
	mov_s r13,r0
L_8e2dc2:
	ld_s r0,[r0,0x8]
L_8e2dc4:
	breq r0,0x2,L_8e2dde
	.global L_8e2dc8
L_8e2dc8:
	ld_s r0,[r13,0x34]
L_8e2dca:
	cmp_s r0,0x0
L_8e2dcc:
	mov_s r0,0x1
L_8e2dce:
	sub_s.ne r0,r0,r0
L_8e2dd0:
	extb.f 0x0,r0
L_8e2dd4:
	beq_s L_8e2df4
L_8e2dd6:
	bl.d L_8db240
L_8e2dda:
	mov_s r0,r13
L_8e2ddc:
	b_s L_8e2df8
	.global L_8e2dde
L_8e2dde:
	mov_s r0,blink
L_8e2de0:
	mov_s r2,0x1015730
L_8e2de6:
	mov_s r1,0x120e
L_8e2dec:
	bl.d L_8c82c0
L_8e2df0:
	mov_s r3,0x26
L_8e2df2:
	b_s L_8e2dc8
	.global L_8e2df4
L_8e2df4:
	mov_s r0,0x2
L_8e2df6:
	st_s r0,[r13,0x8]
	.global L_8e2df8
L_8e2df8:
	b L_8c033c
