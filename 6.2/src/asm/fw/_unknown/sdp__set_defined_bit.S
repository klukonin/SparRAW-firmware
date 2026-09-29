/* sdp__set_defined_bit @ 0x8f43d4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SDP__sdp_init__2, ut_hw_drivers__step_8f4480
 * Зовёт сам: SDP__hwd_sdp_is_defined_sdp, __ld_r14_to_r13_ret, __st_r14_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sdp__set_defined_bit
sdp__set_defined_bit:
	.global L_8f43d4
L_8f43d4:
	push_s blink
L_8f43d6:
	bl L_8c01e4
L_8f43da:
	mov_s r14,r0
L_8f43dc:
	mov_s r13,r1
L_8f43de:
	bl.d L_8f4354
L_8f43e2:
	mov_s r0,r1
L_8f43e4:
	mov_s r2,0x880b00
L_8f43ea:
	ld_s r0,[r2,0x6c]
L_8f43ec:
	mov_s r1,0x0
L_8f43ee:
	bset r1,r1,r13
L_8f43f2:
	cmp_s r14,0x0
L_8f43f4:
	bic.eq r0,r0,r1
L_8f43f8:
	beq_s L_8f43fc
L_8f43fa:
	or_s r0,r0,r1
	.global L_8f43fc
L_8f43fc:
	st_s r0,[r2,0x6c]
L_8f43fe:
	b L_8c0254
L_8f4402:
	nop_s
