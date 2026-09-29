/* sdp__init_int_ctrl @ 0x8f42e4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SDP__sdp_init__2
 * Зовёт сам: SDP__hwd_sdp_is_int_ctrl_sdp, __ld_r13_to_r13_ret, sdp__init_pair
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sdp__init_int_ctrl
sdp__init_int_ctrl:
	.global L_8f42e4
L_8f42e4:
	push_s blink
L_8f42e6:
	push_s r13
L_8f42e8:
	bl.d L_8f43a4
L_8f42ec:
	mov_s r13,r0
L_8f42ee:
	bl.d L_8d4768
L_8f42f2:
	add r0,r13,0xb
L_8f42f6:
	b L_8c025c
L_8f42fa:
	nop_s
