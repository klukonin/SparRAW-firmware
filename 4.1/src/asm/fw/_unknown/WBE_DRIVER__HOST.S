/* WBE_DRIVER__HOST @ 0x8cb698, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WBE_DRIVER::HOST:: CPL TO - GBE WA Closed!!
 * Зовут его: WBE_DRIVER__link_down
 * Зовёт сам: fw_log__emit0
 */
	.section .text.WBE_DRIVER__HOST,"ax",@progbits
	.global WBE_DRIVER__HOST
WBE_DRIVER__HOST:
	.global L_8cb698
L_8cb698:
	push_s blink
L_8cb69a:
	ld_s r0,[gp,-0xe4]
L_8cb69c:
	breq_s r0,0,L_8cb6d2
L_8cb69e:
	mov_s r0,0x0
L_8cb6a0:
	st.as r0,[gp,-0x25]
L_8cb6a4:
	mov_s r2,0x1003374
L_8cb6aa:
	mov_s r0,0xf
L_8cb6ac:
	bl.d L_8edfb0
L_8cb6b0:
	mov_s r1,0x2
L_8cb6b2:
	mov_s r1,0x882580
L_8cb6b8:
	ld_s r0,[r1,0x40]
L_8cb6ba:
	bic r0,r0,0x6
L_8cb6be:
	bset_s r0,r0,0x2
L_8cb6c0:
	st_s r0,[r1,0x40]
L_8cb6c2:
	mov_s r1,0x882c80
L_8cb6c8:
	ld_s r0,[r1,0x6c]
L_8cb6ca:
	bic r0,r0,0xb
L_8cb6ce:
	bset_s r0,r0,0x3
L_8cb6d0:
	st_s r0,[r1,0x6c]
	.global L_8cb6d2
L_8cb6d2:
	pop_s blink
L_8cb6d4:
	j_s [blink]
L_8cb6d6:
	nop_s
