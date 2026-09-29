/* mid__get_awake_window @ 0x8c989c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__update_aw_ie, power_mngr__recalc_aw, ps_assoc_mgr__aw_ie_reception, tx_mgmt_build_step
 */
	.section .text.mid__get_awake_window,"ax",@progbits
	.global mid__get_awake_window
mid__get_awake_window:
	.global L_8c989c
L_8c989c:
	j_s.d [blink]
L_8c989e:
	ldw r0,[r0, 0x52]
L_8c98a2:
	nop_s
