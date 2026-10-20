/* mid__set_awake_window @ 0x8e1590, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__update_aw_ie, ps_assoc_mgr__aw_ie_reception
 * Зовёт сам: lmac_if_update_aw_ie_handler
 */
	.section .text.mid__set_awake_window,"ax",@progbits
	.global mid__set_awake_window
mid__set_awake_window:
	.global L_8e1590
L_8e1590:
	stw r1,[r0, 0x52]
L_8e1594:
	b.d L_8d8de0
L_8e1598:
	mov_s r0,r2
L_8e159a:
	nop_s
