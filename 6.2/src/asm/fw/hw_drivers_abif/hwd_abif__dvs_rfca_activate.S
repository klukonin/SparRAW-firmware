/* hwd_abif__dvs_rfca_activate @ 0x8ce89c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__dvs_rfca_activate
hwd_abif__dvs_rfca_activate:
	.global L_8ce89c
L_8ce89c:
	push_s blink
L_8ce89e:
	bl L_8c01dc
L_8ce8a2:
	mov_s r16,r1
L_8ce8a4:
	bic.f r1,r1,0xff
L_8ce8a8:
	mov_s r13,r0
L_8ce8aa:
	bne_s L_8ce8f0
	.global L_8ce8ac
L_8ce8ac:
	mov_s r14,0x889480
L_8ce8b2:
	ld_s r1,[r14,0x8]
L_8ce8b4:
	mov_s r15,0xff00ffff
L_8ce8ba:
	and_s r1,r1,r15
L_8ce8bc:
	asl r0,r16,0x10
L_8ce8c0:
	or_s r0,r0,r1
L_8ce8c2:
	st_s r0,[r14,0x8]
L_8ce8c4:
	bclr.f r16,r13,0x0
L_8ce8c8:
	bne_s L_8ce8fa
	.global L_8ce8ca
L_8ce8ca:
	brne r16,0x0,L_8ce904
	.global L_8ce8ce
L_8ce8ce:
	mov_s r0,0x889100
L_8ce8d4:
	ld_s r2,[r0,0x54]
L_8ce8d6:
	asl r1,r13,0x10
L_8ce8da:
	bclr_s r2,r2,0xb
L_8ce8dc:
	bclr_s r2,r2,0x10
L_8ce8de:
	or_s r1,r1,r2
L_8ce8e0:
	asl_s r13,r13,0xb
L_8ce8e2:
	or_s r13,r13,r1
L_8ce8e4:
	st_s r13,[r0,0x54]
L_8ce8e6:
	ld_s r0,[r14,0x8]
L_8ce8e8:
	and_s r0,r0,r15
L_8ce8ea:
	st_s r0,[r14,0x8]
L_8ce8ec:
	b L_8c0244
	.global L_8ce8f0
L_8ce8f0:
	mov_s r0,blink
L_8ce8f2:
	bl.d L_8c9b28
L_8ce8f6:
	mov_s r1,0xac
L_8ce8f8:
	b_s L_8ce8ac
	.global L_8ce8fa
L_8ce8fa:
	mov_s r0,blink
L_8ce8fc:
	bl.d L_8c9b28
L_8ce900:
	mov_s r1,0xad
L_8ce902:
	b_s L_8ce8ca
	.global L_8ce904
L_8ce904:
	mov_s r0,blink
L_8ce906:
	bl.d L_8c9b28
L_8ce90a:
	mov_s r1,0xae
L_8ce90c:
	b_s L_8ce8ce
L_8ce90e:
	nop_s
