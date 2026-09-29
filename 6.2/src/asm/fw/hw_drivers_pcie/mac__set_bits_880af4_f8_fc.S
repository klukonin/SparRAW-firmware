/* mac__set_bits_880af4_f8_fc @ 0x8d19a4, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__apply_mode_fw_8825c0__8d10c8, pcie__program_seq_fw_8825c0__8d1114
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__set_bits_880af4_f8_fc
mac__set_bits_880af4_f8_fc:
	.global L_8d19a4
L_8d19a4:
	push_s blink
L_8d19a6:
	bl L_8c01e0
L_8d19aa:
	bclr.f r15,r0,0x0
L_8d19ae:
	mov_s r13,r0
L_8d19b0:
	bne_s L_8d19e2
	.global L_8d19b2
L_8d19b2:
	mov_s r14,0x880a80
L_8d19b8:
	ld_s r1,[r14,0x74]
L_8d19ba:
	asl r0,r13,0x8
L_8d19be:
	bclr_s r1,r1,0x8
L_8d19c0:
	or_s r0,r0,r1
L_8d19c2:
	st_s r0,[r14,0x74]
L_8d19c4:
	brne_s r15,0,L_8d19ec
	.global L_8d19c6
L_8d19c6:
	ld_s r0,[r14,0x78]
L_8d19c8:
	asl r1,r13,0x13
L_8d19cc:
	bclr_s r0,r0,0x13
L_8d19ce:
	or_s r0,r0,r1
L_8d19d0:
	st_s r0,[r14,0x78]
L_8d19d2:
	brne_s r15,0,L_8d19f6
	.global L_8d19d4
L_8d19d4:
	ld_s r0,[r14,0x7c]
L_8d19d6:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_8d19d8:
	bclr_s r0,r0,0x4
L_8d19da:
	or_s r0,r0,r13
L_8d19dc:
	st_s r0,[r14,0x7c]
L_8d19de:
	b L_8c024c
	.global L_8d19e2
L_8d19e2:
	mov_s r0,blink
L_8d19e4:
	bl.d L_8c9b28
L_8d19e8:
	mov_s r1,0xac
L_8d19ea:
	b_s L_8d19b2
	.global L_8d19ec
L_8d19ec:
	mov_s r0,blink
L_8d19ee:
	bl.d L_8c9b28
L_8d19f2:
	mov_s r1,0xac
L_8d19f4:
	b_s L_8d19c6
	.global L_8d19f6
L_8d19f6:
	mov_s r0,blink
L_8d19f8:
	bl.d L_8c9b28
L_8d19fc:
	mov_s r1,0xac
L_8d19fe:
	b_s L_8d19d4
