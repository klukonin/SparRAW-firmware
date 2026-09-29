/* mac__set_duration_us @ 0x926560, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: cf_end__tx_flow, internal_tx_step
 * Зовёт сам: __ld_r13_ret_uc
 */
	.section .text.mac__set_duration_us,"ax",@progbits
	.global mac__set_duration_us
mac__set_duration_us:
	.global L_926560
L_926560:
	push_s blink
L_926562:
	push_s r13
L_926564:
	mulu64 r0,0xa5
L_926568:
	mov_s r0,0x52
L_92656a:
	asl_s r0,r0,0x18
L_92656c:
	mov_s r13,mlo
L_92656e:
	mov_s r32,r0
L_926570:
	st.ab r0,[r25,0x4]
L_926574:
	bclr r25,r25,0xa
L_926578:
	mov_s r0,0x52
L_92657a:
	asl_s r0,r0,0x18
L_92657c:
	mov_s r32,r0
L_92657e:
	st.ab r0,[r25,0x4]
L_926582:
	bclr r25,r25,0xa
L_926586:
	mov_s r0,0x49000040
L_92658c:
	mov_s r32,r0
L_92658e:
	st.ab r0,[r25,0x4]
L_926592:
	bclr r25,r25,0xa
L_926596:
	or r13,r13,0x4f000000
L_92659e:
	mov_s r32,r13
L_9265a0:
	st.ab r13,[r25,0x4]
L_9265a4:
	bclr r25,r25,0xa
L_9265a8:
	mov_s r0,0x52000408
L_9265ae:
	mov_s r32,r0
L_9265b0:
	st.ab r0,[r25,0x4]
L_9265b4:
	bclr r25,r25,0xa
L_9265b8:
	b L_92028c
