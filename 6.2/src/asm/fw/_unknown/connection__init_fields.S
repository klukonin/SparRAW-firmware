/* connection__init_fields @ 0x8e7574, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: connection__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global connection__init_fields
connection__init_fields:
	.global L_8e7574
L_8e7574:
	push_s blink
L_8e7576:
	bl.d L_8c01e4
L_8e757a:
	mov_s r1,0x10
L_8e757c:
	mov_s r14,r0
L_8e757e:
	mov_s r13,0x0
L_8e7580:
	stb r13,[r0, 0x4d]
L_8e7584:
	st_s r13,[r0,0x50]
L_8e7586:
	bl.d L_8c1cd8
L_8e758a:
	add_s r0,r0,0x55
L_8e758c:
	stb r13,[r14, 0x54]
L_8e7590:
	st_s r13,[r14,0x68]
L_8e7592:
	stb r13,[r14, 0x6c]
L_8e7596:
	st.as r13,[gp,-0x5d]
L_8e759a:
	add r14,r14,0x18d
L_8e759e:
	b.d L_8c0254
L_8e75a2:
	stb_s r13,[r14]
