/* vring__get_pring_id @ 0x8c9d94, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__ready_for_modify, ba_sm__pring_id_of_conn, vring__on_macq_delete_ntf, vring__wait_macq_delete, vring_schd__add_vring, vring_schd__fill_vring_cfg
 */
	.section .text.vring__get_pring_id,"ax",@progbits
	.global vring__get_pring_id
vring__get_pring_id:
	.global L_8c9d94
L_8c9d94:
	ld_s r1,[r0,0xc]
L_8c9d96:
	cmp_s r1,0x0
L_8c9d98:
	mov.ne r0,0x8
L_8c9d9c:
	bne_s L_8c9da2
L_8c9d9e:
	ld_s r0,[r0]
L_8c9da0:
	ldb_s r0,[r0,0x8]
	.global L_8c9da2
L_8c9da2:
	j_s [blink]
