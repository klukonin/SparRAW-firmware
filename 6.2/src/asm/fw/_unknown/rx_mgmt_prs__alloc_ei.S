/* rx_mgmt_prs__alloc_ei @ 0x8e0a78, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mgmt_parse failed to allocate EI buffer
 * Зовут его: rx_mgmt_prs__alloc_ei_default, wmi__bump_cmd_counter
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit0, fw_sysassert_fatal, hexdump_words, l2mgr__arm_notify_timer, rx_mgmt__find_free_ei, rx_mgmt_prs__parse
 * Глобалы (через gp): 0x8003f4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_mgmt_prs__alloc_ei
rx_mgmt_prs__alloc_ei:
	.global L_8e0a78
L_8e0a78:
	st_s r1,[r0,0x70]
L_8e0a7a:
	mov_s r1,0x1
L_8e0a7c:
	b.d L_8e48a4
L_8e0a80:
	st_s r1,[r0,0x78]
L_8e0a82:
	nop_s
	.global L_8e0a84
L_8e0a84:
	push_s blink
L_8e0a86:
	bl L_8c01d8
L_8e0a8a:
	mov_s r17,r0
L_8e0a8c:
	mov_s r14,r1
L_8e0a8e:
	ld_s r15,[r1,0x30]
L_8e0a90:
	ld r16,[r1, 0x14]
L_8e0a94:
	bl.d L_8c3370
L_8e0a98:
	mov_s r13,0x0
L_8e0a9a:
	st_s r0,[r14,0xc]
L_8e0a9c:
	brne_s r0,0,L_8e0ab8
L_8e0a9e:
	mov_s r1,0x1014034
L_8e0aa4:
	bl.d L_8dcba8
L_8e0aa8:
	mov_s r0,0xd
L_8e0aaa:
	mov_s r0,blink
L_8e0aac:
	mov_s r1,0xa2
L_8e0aae:
	bl.d L_8c9b28
L_8e0ab2:
	bset_s r1,r1,0xc
L_8e0ab4:
	mov_s r0,r13
L_8e0ab6:
	b_s L_8e0b26
	.global L_8e0ab8
L_8e0ab8:
	ldb r0,[r14, 0x34]
L_8e0abc:
	breq_s r0,0,L_8e0ace
L_8e0abe:
	breq r0,0x1,L_8e0ad6
L_8e0ac2:
	mov_s r0,blink
L_8e0ac4:
	mov_s r1,0xa3
L_8e0ac6:
	bl.d L_8c9b28
L_8e0aca:
	bset_s r1,r1,0xc
L_8e0acc:
	b_s L_8e0ade
	.global L_8e0ace
L_8e0ace:
	mov_s r13,0x18
L_8e0ad0:
	ld_s r0,[r14,0x14]
L_8e0ad2:
	add_s r0,r0,0x18
L_8e0ad4:
	b_s L_8e0adc
	.global L_8e0ad6
L_8e0ad6:
	ld_s r0,[r14,0x14]
L_8e0ad8:
	mov_s r13,0xa
L_8e0ada:
	add_s r0,r0,0xa
	.global L_8e0adc
L_8e0adc:
	st_s r0,[r14,0x14]
	.global L_8e0ade
L_8e0ade:
	ld_s r1,[r14,0x8]
L_8e0ae0:
	ldw_s r0,[r1]
L_8e0ae2:
	lsr_s r0,r0,0x4
L_8e0ae4:
	bmsk_s r0,r0,0x3
L_8e0ae6:
	stw_s r0,[r14,0x2c]
L_8e0ae8:
	ldw_s r0,[r1]
L_8e0aea:
	lsr_s r0,r0,0x2
L_8e0aec:
	bmsk_s r0,r0,0x1
L_8e0aee:
	cmp_s r0,0x3
L_8e0af0:
	mov.ne r0,r16
L_8e0af4:
	bl.ne.d L_8c9790
L_8e0af8:
	mov.ne r1,r15
L_8e0afc:
	ld_s r3,[r14,0x30]
L_8e0afe:
	ld_s r0,[r14,0x8]
L_8e0b00:
	sub_s r3,r3,r13
L_8e0b02:
	ldw_s r13,[r0]
L_8e0b04:
	ld_s r1,[r14,0x14]
L_8e0b06:
	lsr r15,r13,0x4
L_8e0b0a:
	lsr_s r13,r13,0x2
L_8e0b0c:
	mov_s r0,r17
L_8e0b0e:
	ld_s r2,[r14,0xc]
L_8e0b10:
	bmsk r4,r15,0x3
L_8e0b14:
	bl.d L_8de190
L_8e0b18:
	bmsk r5,r13,0x1
L_8e0b1c:
	ld_s r0,[gp,0x270]
L_8e0b1e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e0b20:
	st.as r0,[gp,0x9c]
L_8e0b24:
	mov_s r0,0x1
	.global L_8e0b26
L_8e0b26:
	b L_8c023c
L_8e0b2a:
	nop_s
