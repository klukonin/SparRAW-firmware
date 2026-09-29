/* vring_by_index @ 0x8cacc0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__update_vring_metric, encap_trans_type, l2mgr__program_assoc_vring, l2mgr__vring_drained, mid__setup_bcast_vring, sm_pring__all_wb_done_evt, sm_pring__bind_vring, sm_pring__eop_evt, sm_pring__timeout, sw_vring__ba_agreed
 */
	.section .text.vring_by_index,"ax",@progbits
	.global vring_by_index
vring_by_index:
	.global L_8cacc0
L_8cacc0:
	mov_s r1,0x8062f4
L_8cacc6:
	j_s.d [blink]
L_8cacc8:
	add3 r0,r1,r0
