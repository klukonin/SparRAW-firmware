/* tail_l2mgr__send_traffic_deferral_evt @ 0x8e46f0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if_ps_traffic_deferral_cfg_handler
 * Зовёт сам: l2mgr__send_traffic_deferral_evt
 */
	.section .text.tail_l2mgr__send_traffic_deferral_evt,"ax",@progbits
	.global tail_l2mgr__send_traffic_deferral_evt
tail_l2mgr__send_traffic_deferral_evt:
	.global L_8e46f0
L_8e46f0:
	mov_s r1,r0
L_8e46f2:
	mov_s r0,0x803510
L_8e46f8:
	b L_8dc430
