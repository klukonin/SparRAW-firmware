/* connection__reset_metrics @ 0x8e23b4, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: connection__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memset0_words
 */
	.section .text.connection__reset_metrics,"ax",@progbits
	.global connection__reset_metrics
connection__reset_metrics:
	.global L_8e23b4
L_8e23b4:
	push_s blink
L_8e23b6:
	bl.d L_8c02c4
L_8e23ba:
	mov_s r1,0x10
L_8e23bc:
	mov_s r14,r0
L_8e23be:
	mov_s r13,0x0
L_8e23c0:
	stb r13,[r0, 0x41]
L_8e23c4:
	st_s r13,[r0,0x44]
L_8e23c6:
	bl.d L_8c1a78
L_8e23ca:
	add_s r0,r0,0x49
L_8e23cc:
	stb r13,[r14, 0x48]
L_8e23d0:
	st_s r13,[r14,0x5c]
L_8e23d2:
	stb r13,[r14, 0x60]
L_8e23d6:
	b.d L_8c0334
L_8e23da:
	st.as r13,[gp,-0x56]
L_8e23de:
	nop_s
