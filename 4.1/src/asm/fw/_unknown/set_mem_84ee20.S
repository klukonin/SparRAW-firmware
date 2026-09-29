/* set_mem_84ee20 @ 0x8c1850, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: frag_8c1774
 */
	.section .text.set_mem_84ee20,"ax",@progbits
	.global set_mem_84ee20
set_mem_84ee20:
L_8c1850:
	mov_s r0,0x803e84
L_8c1856:
	b.d L_8c1778
L_8c185a:
	mov_s r1,0x0
L_8c185c:
	mov_s r1,0x84edf4
L_8c1862:
	mov_s r0,0x800740
L_8c1868:
	j_s.d [blink]
L_8c186a:
	st_s r0,[r1,0x2c]
