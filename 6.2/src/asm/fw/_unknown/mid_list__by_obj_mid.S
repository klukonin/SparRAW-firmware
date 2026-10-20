/* mid_list__by_obj_mid @ 0x8cc41c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__send_addba_req, ba_sm__send_delba, vring__enable_first_pending_gtk
 * Зовёт сам: mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid_list__by_obj_mid
mid_list__by_obj_mid:
	.global L_8cc41c
L_8cc41c:
	b.d L_8cc3dc
L_8cc420:
	ld_s r0,[r0,0x8]
L_8cc422:
	nop_s
