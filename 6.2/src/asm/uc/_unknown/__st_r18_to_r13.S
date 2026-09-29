/* __st_r18_to_r13 @ 0x920224, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__process_request_fifo, brp__init_ctx, direct_tx__send_from_desc, l1_fixed_sched_ap__ev4_state2, l1_fixed_sched_ap__ev4_state4, tx__send_and_await_rx_frame, txss__store_sector_ranking, ucode_cmd_0x08_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global __st_r18_to_r13
__st_r18_to_r13:
	.global L_920224
L_920224:
	st.a r18,[sp,-0x4]
