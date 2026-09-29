/* l2mgr__init_oob_pool @ 0x8d5a58, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: mem_pool__init, memset0_words
 */
	.section .text.l2mgr__init_oob_pool,"ax",@progbits
	.global l2mgr__init_oob_pool
l2mgr__init_oob_pool:
	.global L_8d5a58
L_8d5a58:
	push_s blink
L_8d5a5a:
	mov_s r0,0x8485f4
L_8d5a60:
	bl.d L_8c1a78
L_8d5a64:
	mov_s r1,0x28
L_8d5a66:
	mov_s r1,0x847df0
L_8d5a6c:
	sub r0,r1,0x14
L_8d5a70:
	mov_s r2,0xe4
L_8d5a72:
	bl.d L_8c6c70
L_8d5a76:
	mov_s r3,0x9
L_8d5a78:
	mov_s r0,0x0
L_8d5a7a:
	st.as r0,[gp,-0x35]
L_8d5a7e:
	st.as r0,[gp,-0x20]
L_8d5a82:
	st.as r0,[gp,-0x21]
L_8d5a86:
	pop_s blink
L_8d5a88:
	j_s [blink]
L_8d5a8a:
	nop_s
