/* ucode_cmd_0x26_handler @ 0x92c5dc, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: keep_alive__arm_slot
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x26_handler
ucode_cmd_0x26_handler:
	.global L_92c5dc
L_92c5dc:
	b.d L_939484
L_92c5e0:
	ldb_s r0,[r0]
L_92c5e2:
	nop_s
