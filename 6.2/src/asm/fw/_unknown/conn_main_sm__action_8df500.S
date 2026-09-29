/* conn_main_sm__action_8df500 @ 0x8df500, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    NULL Handler -  m_cur_state %d
 * Зовёт сам: fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__action_8df500
conn_main_sm__action_8df500:
	.global L_8df500
L_8df500:
	ldb_s r2,[r0]
L_8df502:
	mov_s r1,0x1011b40
L_8df508:
	b.d L_8dcc10
L_8df50c:
	mov_s r0,0x2b
L_8df50e:
	nop_s
