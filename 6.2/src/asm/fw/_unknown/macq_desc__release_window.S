/* macq_desc__release_window @ 0x8c5238, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: macq_desc__read, macq_desc__read_typed, macq_desc__write, macq_desc__write_type6
 * Глобалы (через gp): 0x800236
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global macq_desc__release_window
macq_desc__release_window:
	.global L_8c5238
L_8c5238:
	ldb_s r0,[gp,0xb2]
L_8c523a:
	brne_s r0,0,L_8c5246
L_8c523c:
	mov_s r1,0x0
L_8c523e:
	mov_s r0,0x886600
L_8c5244:
	st_s r1,[r0,0x8]
	.global L_8c5246
L_8c5246:
	j_s [blink]
