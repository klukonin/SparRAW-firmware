/* set_g_8000c0_x2 @ 0x8de5b8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SW_TX_MGMT_API__link_up_evt, sw_tx_mgmt__acquire_link, tx_api__tx_complete_cb
 * Глобалы (через gp): 0x80017c
 */
	.section .text.set_g_8000c0_x2,"ax",@progbits
	.global set_g_8000c0_x2
set_g_8000c0_x2:
	.global L_8de5b8
L_8de5b8:
	mov_s r0,0x0
L_8de5ba:
	st.as r0,[gp,-0x2c]
L_8de5be:
	j_s.d [blink]
L_8de5c0:
	st.as r0,[gp,0x3]
