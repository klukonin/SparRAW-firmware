/* lmac_echo__report_to_host @ 0x8e0984, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if_echo_evt_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_if__post_event, mbox__debug_init_flow
 */
	.section .text.lmac_echo__report_to_host,"ax",@progbits
	.global lmac_echo__report_to_host
lmac_echo__report_to_host:
	.global L_8e0984
L_8e0984:
	push_s blink
L_8e0986:
	bl L_8c02bc
L_8e098a:
	mov_s r16,r0
L_8e098c:
	mov_s r15,r1
L_8e098e:
	mov_s r13,r2
L_8e0990:
	bl.d L_8d6ea8
L_8e0994:
	mov_s r14,r3
L_8e0996:
	mov_s r1,r16
L_8e0998:
	mov_s r2,0x0
L_8e099a:
	mov_s r3,r15
L_8e099c:
	mov_s r4,r13
L_8e099e:
	mov_s r5,r14
L_8e09a0:
	mov_s r6,r2
L_8e09a2:
	bl.d L_8e0460
L_8e09a6:
	mov_s r7,r2
L_8e09a8:
	b L_8c0324
