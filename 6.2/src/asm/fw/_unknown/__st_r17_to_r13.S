/* __st_r17_to_r13 @ 0x8c01d8, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CONNECTION__awake_peer_ntf, TX_API__awake_peer_ntf, WBE_DRIVER__pxe_isoc_in_dir_bypass, abif__set_nibble_all_chains, ba_sm__build_addba_params, ba_sm__send_delba, brd_if__chunk_offset, brd_if_multi_array__find_section, brd_if_multi_array__get_block_info, brd_if_multi_array__get_chunk_8cbbc4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global __st_r17_to_r13
__st_r17_to_r13:
	.global L_8c01d8
L_8c01d8:
	st.a r17,[sp,-0x4]
