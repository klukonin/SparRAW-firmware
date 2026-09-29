/* sm__null_handler @ 0x8db250, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    NULL Handler -  m_cur_state %d
 * Зовёт сам: fw_log__emit1
 */
	.section .text.sm__null_handler,"ax",@progbits
	.global sm__null_handler
sm__null_handler:
L_8db250:
	mov_s r2,0x100f83c
L_8db256:
	ldb_s r3,[r0]
L_8db258:
	mov_s r0,0xb
L_8db25a:
	b.d L_8edfcc
L_8db25e:
	mov_s r1,0x2
