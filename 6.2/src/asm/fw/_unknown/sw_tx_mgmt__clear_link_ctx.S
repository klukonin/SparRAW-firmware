/* sw_tx_mgmt__clear_link_ctx @ 0x8e2930, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SW_TX_MGMT_API__link_up_evt, sw_tx_mgmt__acquire_link, sw_tx_mgmt__tx_complete_cb
 * Глобалы (через gp): 0x800184
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sw_tx_mgmt__clear_link_ctx
sw_tx_mgmt__clear_link_ctx:
	.global L_8e2930
L_8e2930:
	mov_s r0,0x0
L_8e2932:
	st.as r0,[gp,-0x30]
L_8e2936:
	j_s.d [blink]
L_8e2938:
	st.as r0,[gp,0x0]
