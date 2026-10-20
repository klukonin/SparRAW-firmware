/* mid__set_awake_window @ 0x8e62f0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__update_aw_ie, ps_assoc_mgr__aw_ie_reception
 * Зовёт сам: lmac_if_update_aw_ie_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__set_awake_window
mid__set_awake_window:
	.global L_8e62f0
L_8e62f0:
	stw r1,[r0, 0x52]
L_8e62f4:
	b.d L_8dc334
L_8e62f8:
	mov_s r0,r2
L_8e62fa:
	nop_s
