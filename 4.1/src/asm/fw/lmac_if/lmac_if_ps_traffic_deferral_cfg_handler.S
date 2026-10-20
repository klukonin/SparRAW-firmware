/* lmac_if_ps_traffic_deferral_cfg_handler @ 0x8d8ca0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: tail_l2mgr__send_traffic_deferral_evt
 */
	.section .text.lmac_if_ps_traffic_deferral_cfg_handler,"ax",@progbits
	.global lmac_if_ps_traffic_deferral_cfg_handler
lmac_if_ps_traffic_deferral_cfg_handler:
	.global L_8d8ca0
L_8d8ca0:
	ld_s r0,[r0,0x4]
L_8d8ca2:
	cmp_s r0,0x0
L_8d8ca4:
	mov_s r0,0x1
L_8d8ca6:
	b.d L_8e46f0
L_8d8caa:
	sub_s.ne r0,r0,r0
