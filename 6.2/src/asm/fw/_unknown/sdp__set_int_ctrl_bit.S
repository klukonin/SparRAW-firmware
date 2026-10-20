/* sdp__set_int_ctrl_bit @ 0x8f42fc, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SDP__sdp_init__2
 * Зовёт сам: SDP__hwd_sdp_is_int_ctrl_sdp, __ld_r14_to_r13_ret, __st_r14_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sdp__set_int_ctrl_bit
sdp__set_int_ctrl_bit:
	.global L_8f42fc
L_8f42fc:
	push_s blink
L_8f42fe:
	bl L_8c01e4
L_8f4302:
	mov_s r13,r0
L_8f4304:
	mov_s r14,r1
L_8f4306:
	bl.d L_8f43a4
L_8f430a:
	mov_s r0,r1
L_8f430c:
	sub_s r14,r14,0xa
L_8f430e:
	extb_s r14,r14
L_8f4310:
	mov_s r2,0x880b80
L_8f4316:
	ld_s r0,[r2,0x34]
L_8f4318:
	mov_s r1,0x0
L_8f431a:
	bset r1,r1,r14
L_8f431e:
	cmp_s r13,0x0
L_8f4320:
	bic.eq r0,r0,r1
L_8f4324:
	beq_s L_8f4328
L_8f4326:
	or_s r0,r0,r1
	.global L_8f4328
L_8f4328:
	st_s r0,[r2,0x34]
L_8f432a:
	b L_8c0254
L_8f432e:
	nop_s
