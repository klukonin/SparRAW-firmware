/* txop__pick_ctrl_code_by_peer @ 0x93db98, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__rx_flow, tx_sta__run_txop
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txop__pick_ctrl_code_by_peer
txop__pick_ctrl_code_by_peer:
	.global L_93db98
L_93db98:
	mov_s r1,0xc
L_93db9a:
	st_s r1,[r0,0x1c]
L_93db9c:
	ld_s r1,[r0,0x4]
L_93db9e:
	mov_s r2,0x802228
L_93dba4:
	add1_s r1,r1,r1
L_93dba6:
	ldb_s r1,[r2,r1]
L_93dba8:
	breq_s r1,0,L_93dbae
L_93dbaa:
	mov_s r1,0xf
L_93dbac:
	st_s r1,[r0,0x1c]
	.global L_93dbae
L_93dbae:
	j_s [blink]
