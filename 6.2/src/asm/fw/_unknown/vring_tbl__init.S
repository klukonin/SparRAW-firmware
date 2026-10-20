/* vring_tbl__init @ 0x8d8c7c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: mem_pool__init, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_tbl__init
vring_tbl__init:
	.global L_8d8c7c
L_8d8c7c:
	push_s blink
L_8d8c7e:
	mov_s r0,0x847f80
L_8d8c84:
	bl.d L_8c1cd8
L_8d8c88:
	mov_s r1,0x28
L_8d8c8a:
	mov_s r1,0x847b48
L_8d8c90:
	sub r0,r1,0x14
L_8d8c94:
	mov_s r2,0x78
L_8d8c96:
	bl.d L_8c7cf8
L_8d8c9a:
	mov_s r3,0x9
L_8d8c9c:
	mov_s r0,0x0
L_8d8c9e:
	st.as r0,[gp,-0x39]
L_8d8ca2:
	st.as r0,[gp,-0x25]
L_8d8ca6:
	st.as r0,[gp,-0x26]
L_8d8caa:
	pop_s blink
L_8d8cac:
	j_s [blink]
L_8d8cae:
	nop_s
