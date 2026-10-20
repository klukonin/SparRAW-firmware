/* sdp__read_880b98_bit @ 0x8f4404, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ut_hw_drivers__zero_result
 * Зовёт сам: SDP__hwd_sdp_is_defined_sdp, __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sdp__read_880b98_bit
sdp__read_880b98_bit:
	.global L_8f4404
L_8f4404:
	push_s blink
L_8f4406:
	push_s r13
L_8f4408:
	bl.d L_8f4354
L_8f440c:
	mov_s r13,r0
L_8f440e:
	mov_s r0,0x880b80
L_8f4414:
	ld_s r1,[r0,0x18]
L_8f4416:
	mov_s r0,0x0
L_8f4418:
	bset r0,r0,r13
L_8f441c:
	and_s r0,r0,r1
L_8f441e:
	b.d L_8c025c
L_8f4422:
	lsr_s r0,r0,r13
