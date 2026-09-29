/* macq_desc__wait_window_free @ 0x8c50e4, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: macq_desc__read, macq_desc__read_typed, macq_desc__write, macq_desc__write_type6
 * Глобалы (через gp): 0x800236
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global macq_desc__wait_window_free
macq_desc__wait_window_free:
	.global L_8c50e4
L_8c50e4:
	ldb_s r0,[gp,0xb2]
L_8c50e6:
	brne_s r0,0,L_8c50f4
	.global L_8c50e8
L_8c50e8:
	mov_s r0,0x886600
L_8c50ee:
	ld_s r0,[r0,0x8]
L_8c50f0:
	bbit1 r0,0x1f,L_8c50e8
	.global L_8c50f4
L_8c50f4:
	j_s [blink]
L_8c50f6:
	nop_s
