/* set_mem_842aa0_x2 @ 0x8c186c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.set_mem_842aa0_x2,"ax",@progbits
	.global set_mem_842aa0_x2
set_mem_842aa0_x2:
L_8c186c:
	mov_s r1,0x842aa0
L_8c1872:
	mov_s r0,0x800814
L_8c1878:
	st_s r0,[r1]
L_8c187a:
	mov_s r0,0x800820
L_8c1880:
	j_s.d [blink]
L_8c1882:
	st_s r0,[r1,0x4]
