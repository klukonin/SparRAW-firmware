/* set_mem_85726c_8e555c @ 0x8e555c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__handle_rx_frame, ese_cfg__apply
 */
	.section .text.set_mem_85726c_8e555c,"ax",@progbits
	.global set_mem_85726c_8e555c
set_mem_85726c_8e555c:
	.global L_8e555c
L_8e555c:
	mov_s r1,0x0
L_8e555e:
	mov_s r0,0x857260
L_8e5564:
	j_s.d [blink]
L_8e5566:
	stb_s r1,[r0,0xc]
