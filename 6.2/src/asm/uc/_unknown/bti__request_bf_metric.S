/* bti__request_bf_metric @ 0x923c8c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_bi2__track_best_metric
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti__request_bf_metric
bti__request_bf_metric:
	.global L_923c8c
L_923c8c:
	push_s r13
L_923c8e:
	mov_s r13,blink
L_923c90:
	mov_s r0,0x5200000e
L_923c96:
	mov_s r32,r0
L_923c98:
	st.ab r0,[r25,0x4]
L_923c9c:
	bclr r25,r25,0xa
L_923ca0:
	mov_s blink,r13
L_923ca2:
	j_s.d [blink]
L_923ca4:
	pop_s r13
L_923ca6:
	nop_s
