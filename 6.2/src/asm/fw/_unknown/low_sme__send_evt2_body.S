/* low_sme__send_evt2_body @ 0x8cb1bc, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: low_sme__send_evt2sw
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal, low_sme__check_state_1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global low_sme__send_evt2_body
low_sme__send_evt2_body:
	.global L_8cb1bc
L_8cb1bc:
	push_s blink
L_8cb1be:
	bl L_8c01d8
L_8cb1c2:
	mov_s r15,r0
L_8cb1c4:
	mov.f r14,r1
L_8cb1c8:
	mov_s r17,r2
L_8cb1ca:
	mov_s r16,r3
L_8cb1cc:
	beq_s L_8cb1f8
	.global L_8cb1ce
L_8cb1ce:
	lr r13,[0xa]
L_8cb1d2:
	bclr r0,r13,0x1
L_8cb1d6:
	flag r0
L_8cb1da:
	add_s r0,r15,0x4
L_8cb1dc:
	mov_s r1,r14
L_8cb1de:
	mov_s r2,r17
L_8cb1e0:
	bl.d L_8cb0b4
L_8cb1e4:
	mov_s r3,r16
L_8cb1e6:
	lr r0,[0xa]
L_8cb1ea:
	bic r13,r13,-0x3
L_8cb1ee:
	or_s r13,r13,r0
L_8cb1f0:
	flag r13
L_8cb1f4:
	b L_8c023c
	.global L_8cb1f8
L_8cb1f8:
	mov_s r0,blink
L_8cb1fa:
	bl.d L_8c9b28
L_8cb1fe:
	mov_s r1,0xc2
L_8cb200:
	b_s L_8cb1ce
L_8cb202:
	nop_s
