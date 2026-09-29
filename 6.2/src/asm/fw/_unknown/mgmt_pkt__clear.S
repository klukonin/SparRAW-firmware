/* mgmt_pkt__clear @ 0x8cb160, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_pkt__release
 * Зовёт сам: __ld_r13_to_r13_ret, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_pkt__clear
mgmt_pkt__clear:
	.global L_8cb160
L_8cb160:
	push_s blink
L_8cb162:
	push_s r13
L_8cb164:
	mov.f r13,r1
L_8cb168:
	beq_s L_8cb17c
L_8cb16a:
	ld_s r0,[r13]
L_8cb16c:
	brne r0,0x1,L_8cb17c
L_8cb170:
	mov_s r0,r13
L_8cb172:
	bl.d L_8c1cd8
L_8cb176:
	mov_s r1,0xd4
L_8cb178:
	mov_s r0,0x0
L_8cb17a:
	st_s r0,[r13]
	.global L_8cb17c
L_8cb17c:
	b L_8c025c
