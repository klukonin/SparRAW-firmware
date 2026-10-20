/* wmi_evt__fill_payload @ 0x8cadf8, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_evt__build_and_post
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_mailbox__is_empty, fw_sysassert_fatal, lm_sm__action_8ddb58, lmac_if__evt_fields, wmi_evt__walk_list
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_evt__fill_payload
wmi_evt__fill_payload:
	.global L_8cadf8
L_8cadf8:
	push_s blink
L_8cadfa:
	bl L_8c01dc
L_8cadfe:
	mov.f r15,r1
L_8cae02:
	mov_s r14,r0
L_8cae04:
	beq_s L_8cae56
	.global L_8cae06
L_8cae06:
	bl.d L_8da150
L_8cae0a:
	mov_s r0,r14
L_8cae0c:
	breq_s r0,0,L_8cae60
	.global L_8cae0e
L_8cae0e:
	lr r16,[0xa]
L_8cae12:
	bclr r0,r16,0x1
L_8cae16:
	flag r0
L_8cae1a:
	ld_s r0,[r14,0x14]
L_8cae1c:
	brne r0,0x1,L_8cae38
L_8cae20:
	ld_s r13,[r14,0x4]
L_8cae22:
	b_s L_8cae2e
	.global L_8cae24
L_8cae24:
	mov_s r0,r14
L_8cae26:
	bl.d L_8cafb4
L_8cae2a:
	mov_s r1,r13
L_8cae2c:
	add_s r13,r13,0x8
	.global L_8cae2e
L_8cae2e:
	ld_s r0,[r14,0x8]
L_8cae30:
	brlo r13,r0,L_8cae24
L_8cae34:
	ld_s r0,[r14]
L_8cae36:
	st_s r15,[r0,0x4]
	.global L_8cae38
L_8cae38:
	ld_s r0,[r14]
L_8cae3a:
	mov_s r1,0x1
L_8cae3c:
	st_s r1,[r0]
L_8cae3e:
	bl.d L_8d86c0
L_8cae42:
	mov_s r0,r14
L_8cae44:
	lr r1,[0xa]
L_8cae48:
	and r0,r16,0x2
L_8cae4c:
	or_s r0,r0,r1
L_8cae4e:
	flag r0
L_8cae52:
	b L_8c0244
	.global L_8cae56
L_8cae56:
	mov_s r0,blink
L_8cae58:
	bl.d L_8c9b28
L_8cae5c:
	mov_s r1,0xca
L_8cae5e:
	b_s L_8cae06
	.global L_8cae60
L_8cae60:
	mov_s r0,blink
L_8cae62:
	bl.d L_8c9b28
L_8cae66:
	mov_s r1,0xcb
L_8cae68:
	b_s L_8cae0e
L_8cae6a:
	nop_s
L_8cae6c:
	b L_8ddba4
