/* us_from_ticks165 @ 0x931c98, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ifs_cfg__program_from_hw_cfg, rx_flow_step
 */
	.section .text.us_from_ticks165,"ax",@progbits
	.global us_from_ticks165
us_from_ticks165:
	.global L_931c98
L_931c98:
	mov_s r2,0x0
L_931c9a:
	b_s L_931ca0
	.global L_931c9c
L_931c9c:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_931c9e:
	sub_s r0,r0,r3
	.global L_931ca0
L_931ca0:
	mov_s r3,0xa5
L_931ca2:
	brhs r0,r3,L_931c9c
L_931ca6:
	stb_s r2,[r1,0x1]
L_931ca8:
	j_s.d [blink]
L_931caa:
	stb_s r0,[r1]
