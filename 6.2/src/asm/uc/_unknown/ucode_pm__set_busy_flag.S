/* ucode_pm__set_busy_flag @ 0x93c874, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__process_request_fifo, rx_funcs__handle_ppdu_report, sta__apply_bf_result, ucode_cmd_0x13_handler, ucode_cmd_trigger_bf
 * Зовёт сам: ucode_pm__stamp_tsf_slots
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_pm__set_busy_flag
ucode_pm__set_busy_flag:
	.global L_93c874
L_93c874:
	push_s blink
L_93c876:
	mov_s r1,0x8014a4
L_93c87c:
	cmp_s r0,0x0
L_93c87e:
	st_s r0,[r1,0x10]
L_93c880:
	bl.ne L_93c7a8
L_93c884:
	pop_s blink
L_93c886:
	j_s [blink]
