/* mac__enable_qset_bit7 @ 0x928e38, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_res_886f00__acquire
 * Зовёт сам: mac__publish_masks
 */
	.section .text.mac__enable_qset_bit7,"ax",@progbits
	.global mac__enable_qset_bit7
mac__enable_qset_bit7:
	.global L_928e38
L_928e38:
	push_s blink
L_928e3a:
	ld_s r0,[gp,-0x74]
L_928e3c:
	bset_s r0,r0,0x7
L_928e3e:
	bl.d L_9373b0
L_928e42:
	st.as r0,[gp,-0x1d]
L_928e46:
	ld_s r0,[gp,-0x58]
L_928e48:
	mov_s r1,0x886f00
L_928e4e:
	bset_s r0,r0,0x1f
L_928e50:
	st.as r0,[gp,-0x16]
L_928e54:
	st_s r0,[r1,0x5c]
L_928e56:
	pop_s blink
L_928e58:
	j_s [blink]
L_928e5a:
	nop_s
