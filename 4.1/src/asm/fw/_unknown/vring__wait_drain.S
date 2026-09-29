/* vring__wait_drain @ 0x8c3c14, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Wait start_b_idx != tail_idx ...
 *   Wait prp_avail_vec_val ...
 * Зовут его: l2mgr__data_port_open, vring__on_macq_delete_ntf
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, tail_vring__write_macq_desc, tail_vring__write_macq_desc_8df898, tail_vring__write_macq_desc_8df8a4
 */
	.section .text.vring__wait_drain,"ax",@progbits
	.global vring__wait_drain
vring__wait_drain:
	.global L_8c3c14
L_8c3c14:
	push_s blink
L_8c3c16:
	bl.d L_8c02c0
L_8c3c1a:
	mov_s r1,0x2
L_8c3c1c:
	mov_s r14,r0
L_8c3c1e:
	mov_s r13,0x84863c
L_8c3c24:
	mov_s r2,0x1015b38
L_8c3c2a:
	bl.d L_8edfb0
L_8c3c2e:
	mov_s r0,0x7
	.global L_8c3c30
L_8c3c30:
	mov_s r0,r13
L_8c3c32:
	bl.d L_8df88c
L_8c3c36:
	ldb_s r1,[r14]
L_8c3c38:
	mov_s r15,0x84861c
L_8c3c3e:
	mov_s r0,r15
L_8c3c40:
	bl.d L_8df898
L_8c3c44:
	ldb_s r1,[r14]
L_8c3c46:
	add3 r0,r15,0xa
L_8c3c4a:
	bl.d L_8df8a4
L_8c3c4e:
	ldb_s r1,[r14]
L_8c3c50:
	mov_s r0,0xa0
L_8c3c52:
	mov lp_count,r0
L_8c3c56:
	nop_s
L_8c3c58:
	lp L_8c3c60
L_8c3c5c:
	nop_s
L_8c3c5e:
	nop_s
	.global L_8c3c60
L_8c3c60:
	ldb_s r1,[r13,0xd]
L_8c3c62:
	ldb_s r0,[r13,0xb]
L_8c3c64:
	brne r1,r0,L_8c3c30
L_8c3c68:
	mov_s r2,0x1015b5c
L_8c3c6e:
	mov_s r0,0x7
L_8c3c70:
	bl.d L_8edfb0
L_8c3c74:
	mov_s r1,0x2
	.global L_8c3c76
L_8c3c76:
	mov_s r0,0x886800
L_8c3c7c:
	ld_s r13,[r0,0x2c]
L_8c3c7e:
	mov_s r0,0xa0
L_8c3c80:
	mov lp_count,r0
L_8c3c84:
	nop_s
L_8c3c86:
	lp L_8c3c8e
L_8c3c8a:
	nop_s
L_8c3c8c:
	nop_s
	.global L_8c3c8e
L_8c3c8e:
	ldb_s r0,[r14]
L_8c3c90:
	bbit1 r13,r0,L_8c3c76
L_8c3c94:
	b L_8c032c
