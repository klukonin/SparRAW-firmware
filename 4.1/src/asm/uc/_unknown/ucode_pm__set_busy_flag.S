/* ucode_pm__set_busy_flag @ 0x936d50, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__background_step, bf_sm__start_request, rx_funcs__handle_ppdu_report, ucode_cmd__rs_enable, ucode_cmd_trigger_bf
 * Зовёт сам: ucode_pm__stamp_tsf_slots
 */
	.section .text.ucode_pm__set_busy_flag,"ax",@progbits
	.global ucode_pm__set_busy_flag
ucode_pm__set_busy_flag:
	.global L_936d50
L_936d50:
	push_s blink
L_936d52:
	mov_s r1,0x8009cc
L_936d58:
	cmp_s r0,0x0
L_936d5a:
	st_s r0,[r1,0x10]
L_936d5c:
	bl.ne L_936c7c
L_936d60:
	pop_s blink
L_936d62:
	j_s [blink]
