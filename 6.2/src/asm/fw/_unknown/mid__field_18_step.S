/* mid__field_18_step @ 0x8cbf18, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_ppdu_ageing_timeout_detector__task
 * Зовёт сам: conn_mgr__by_cid, scan_mngr__update_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__field_18_step
mid__field_18_step:
	.global L_8cbf18
L_8cbf18:
	push_s blink
L_8cbf1a:
	bl L_8cbffc
L_8cbf1e:
	ld_s r0,[r0,0x18]
L_8cbf20:
	bl.d L_8cbee8
L_8cbf24:
	ld.as r0,[r0,0x8f]
L_8cbf28:
	pop_s blink
L_8cbf2a:
	j_s [blink]
