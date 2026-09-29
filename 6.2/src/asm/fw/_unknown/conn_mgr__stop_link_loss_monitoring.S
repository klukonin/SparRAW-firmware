/* conn_mgr__stop_link_loss_monitoring @ 0x8e7fb4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__set_link_maintain_cfg, conn_mgr__system_state_evt_handler
 * Зовёт сам: lm_if__stop_link_loss_monitoring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__stop_link_loss_monitoring
conn_mgr__stop_link_loss_monitoring:
	.global L_8e7fb4
L_8e7fb4:
	b.d L_8e7fbc
L_8e7fb8:
	add_s r0,r0,0x70
L_8e7fba:
	nop_s
