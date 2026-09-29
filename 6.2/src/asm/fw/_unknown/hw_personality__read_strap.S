/* hw_personality__read_strap @ 0x8f4424, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_personality_detect, ut_hw_drivers__zero_result
 * Зовёт сам: SDP__hwd_sdp_is_defined_sdp, __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_personality__read_strap
hw_personality__read_strap:
	.global L_8f4424
L_8f4424:
	push_s blink
L_8f4426:
	push_s r13
L_8f4428:
	bl.d L_8f4354
L_8f442c:
	mov_s r13,r0
L_8f442e:
	mov_s r0,0x880b00
L_8f4434:
	ld_s r1,[r0,0x7c]
L_8f4436:
	mov_s r0,0x0
L_8f4438:
	bset r0,r0,r13
L_8f443c:
	and_s r0,r0,r1
L_8f443e:
	b.d L_8c025c
L_8f4442:
	lsr_s r0,r0,r13
