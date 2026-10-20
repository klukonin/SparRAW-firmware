/* vring__get_pring_id @ 0x8cbed8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__ADD, ba_sm__action_8c4394, stream_mgr__ready_for_modify, vring__get_pring_id_of_obj, vring_schd__fill_vring_cfg
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__get_pring_id
vring__get_pring_id:
	.global L_8cbed8
L_8cbed8:
	ld_s r1,[r0,0xc]
L_8cbeda:
	cmp_s r1,0x0
L_8cbedc:
	mov.ne r0,0x8
L_8cbee0:
	bne_s L_8cbee6
L_8cbee2:
	ld_s r0,[r0]
L_8cbee4:
	ldb_s r0,[r0,0x8]
	.global L_8cbee6
L_8cbee6:
	j_s [blink]
