/* set_mem_85726c @ 0x8e196c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__handle_rx_frame, ese_cfg__apply
 */
	.section .text.set_mem_85726c,"ax",@progbits
	.global set_mem_85726c
set_mem_85726c:
	.global L_8e196c
L_8e196c:
	mov_s r1,0x1
L_8e196e:
	mov_s r0,0x857260
L_8e1974:
	j_s.d [blink]
L_8e1976:
	stb_s r1,[r0,0xc]
