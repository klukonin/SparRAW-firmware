/* conn__stop_link_loss_monitoring @ 0x8e2ec8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__set_link_maintain_cfg, conn_mgr__system_state_evt_handler
 * Зовёт сам: lm_if__stop_link_loss_monitoring
 */
	.section .text.conn__stop_link_loss_monitoring,"ax",@progbits
	.global conn__stop_link_loss_monitoring
conn__stop_link_loss_monitoring:
	.global L_8e2ec8
L_8e2ec8:
	b.d L_8e2ed0
L_8e2ecc:
	add_s r0,r0,0x64
L_8e2ece:
	nop_s
