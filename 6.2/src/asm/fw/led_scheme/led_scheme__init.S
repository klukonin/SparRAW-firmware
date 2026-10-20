/* led_scheme__init @ 0x8da81c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, hw_ch__enable_once
 * Глобалы (через gp): 0x8003bc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global led_scheme__init
led_scheme__init:
	.global L_8da81c
L_8da81c:
	push_s blink
L_8da81e:
	push_s r13
L_8da820:
	brhs.d r0,0x4,L_8da83c
L_8da824:
	mov_s r13,r0
	.global L_8da826
L_8da826:
	breq r13,0x3,L_8da82e
L_8da82a:
	st.as r13,[gp,0x8e]
	.global L_8da82e
L_8da82e:
	ld_s r0,[gp,0x238]
L_8da830:
	mov_s r1,0x0
L_8da832:
	bl.d L_8da790
L_8da836:
	mov_s r2,0x64
L_8da838:
	b L_8c025c
	.global L_8da83c
L_8da83c:
	mov_s r0,blink
L_8da83e:
	mov_s r1,0x1157
L_8da844:
	bl L_8c9b28
L_8da848:
	b_s L_8da826
L_8da84a:
	nop_s
