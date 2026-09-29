/* ucode_cmd_0x12_handler @ 0x92c434, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r13_ret_uc, rate_search__reset_sta, rate_search__start_for_sta
 */
	.section .text.ucode_cmd_0x12_handler,"ax",@progbits
	.global ucode_cmd_0x12_handler
ucode_cmd_0x12_handler:
	.global L_92c434
L_92c434:
	push_s blink
L_92c436:
	push_s r13
L_92c438:
	mov_s r13,r0
L_92c43a:
	bl.d L_92bd80
L_92c43e:
	ldb_s r0,[r0]
L_92c440:
	ldb_s r0,[r13]
L_92c442:
	bl.d L_92c34c
L_92c446:
	mov_s r1,0x0
L_92c448:
	b L_92028c
