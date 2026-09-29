/* vring_ctx_by_index @ 0x8ca828, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_offload__cfg_rx_decap, l2mgr__data_port_open, rx_macq__init, sw_vring__ba_agreed, vring__on_macq_delete_ntf, wmi_handler_cfg_rx_chain
 */
	.section .text.vring_ctx_by_index,"ax",@progbits
	.global vring_ctx_by_index
vring_ctx_by_index:
	.global L_8ca828
L_8ca828:
	asl_s r1,r0,0x4
L_8ca82a:
	add r0,r1,0x843588
L_8ca832:
	j_s [blink]
