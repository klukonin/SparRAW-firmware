/* mid__get_aw_len @ 0x8cb914, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__update_aw_ie, power_mngr__recalc_aw, ps_assoc_mgr__aw_ie_reception, tx_mgmt_build_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__get_aw_len
mid__get_aw_len:
	.global L_8cb914
L_8cb914:
	j_s.d [blink]
L_8cb916:
	ldw r0,[r0, 0x52]
L_8cb91a:
	nop_s
