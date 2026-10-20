/* bti__request_bf_metric @ 0x923db8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__collect_bf_metric
 */
	.section .text.bti__request_bf_metric,"ax",@progbits
	.global bti__request_bf_metric
bti__request_bf_metric:
	.global L_923db8
L_923db8:
	push_s r13
L_923dba:
	mov_s r13,blink
L_923dbc:
	mov_s r0,0x5200000e
L_923dc2:
	mov_s r32,r0
L_923dc4:
	st.ab r0,[r25,0x4]
L_923dc8:
	bclr r25,r25,0xa
L_923dcc:
	mov_s blink,r13
L_923dce:
	j_s.d [blink]
L_923dd0:
	pop_s r13
L_923dd2:
	nop_s
