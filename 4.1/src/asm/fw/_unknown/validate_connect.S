/* validate_connect @ 0x8f295c, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   validate_connect: Error. FW_CHANNEL_4_64800MHZ isn't supported
 *   validate_connect: Error in MAC address
 *   validate_connect: WMI Connect is not allowed in PCP mode
 *   validate_connect: WMI Connect MID:[%d] ignored - already connected MIDs
 *   validate_connect: WMI Connect MID:[%d] ignored while scning.s
 * Зовут его: wmi_handler_connect
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, fw_log__emit1, mid_list__any_in_state2, mid_list__by_mid, mid_list__count_active
 */
	.section .text.validate_connect,"ax",@progbits
	.global validate_connect
validate_connect:
	.global L_8f295c
L_8f295c:
	push_s blink
L_8f295e:
	bl L_8c02c0
L_8f2962:
	mov_s r15,r0
L_8f2964:
	bl.d L_8ca1b0
L_8f2968:
	mov_s r14,r1
L_8f296a:
	mov_s r13,r0
L_8f296c:
	brne r14,0x3,L_8f2982
L_8f2970:
	mov_s r2,0x100d770
	.global L_8f2976
L_8f2976:
	mov_s r0,0xb
L_8f2978:
	mov_s r1,0x0
	.global L_8f297a
L_8f297a:
	bl L_8edfb0
L_8f297e:
	mov_s r0,0x0
L_8f2980:
	b_s L_8f29d6
	.global L_8f2982
L_8f2982:
	bl.d L_8ca1b0
L_8f2986:
	mov_s r0,r15
L_8f2988:
	ldb_s r0,[r0,0xa]
L_8f298a:
	bxor r0,r0,0x0
L_8f298e:
	bbit1 r0,0x0,L_8f299a
L_8f2992:
	mov_s r2,0x100d7b0
L_8f2998:
	b_s L_8f2976
	.global L_8f299a
L_8f299a:
	ld_s r0,[r13,0x50]
L_8f299c:
	brne r0,0x2,L_8f29ac
L_8f29a0:
	mov_s r2,0x100d7d8
L_8f29a6:
	mov_s r0,0xb
L_8f29a8:
	mov_s r1,0x1
L_8f29aa:
	b_s L_8f297a
	.global L_8f29ac
L_8f29ac:
	bl L_8c307c
L_8f29b0:
	breq_s r0,0,L_8f29c6
L_8f29b2:
	mov_s r2,0x100d814
	.global L_8f29b8
L_8f29b8:
	mov_s r0,0xb
L_8f29ba:
	mov_s r1,0x2
L_8f29bc:
	bl.d L_8edfcc
L_8f29c0:
	mov_s r3,r15
L_8f29c2:
	mov_s r0,0x0
L_8f29c4:
	b_s L_8f29d6
	.global L_8f29c6
L_8f29c6:
	bl L_8c9798
L_8f29ca:
	breq_s r0,0,L_8f29d4
L_8f29cc:
	mov_s r2,0x100d85c
L_8f29d2:
	b_s L_8f29b8
	.global L_8f29d4
L_8f29d4:
	mov_s r0,0x1
	.global L_8f29d6
L_8f29d6:
	b L_8c032c
L_8f29da:
	nop_s
