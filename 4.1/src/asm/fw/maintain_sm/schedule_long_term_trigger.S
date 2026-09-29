/* schedule_long_term_trigger @ 0x8dfa80, 236 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   schedule_long_term_trigger: max mcs=%d , current mcs:%d
 *   maintain_sm.cpp
 *   schedule_long_term_trigger: no long term on max mcs
 * Зовут его: bf__fail_retrying, maintain_sm__on_resume_maintain, maintain_sm__on_rs_results, rs__need_long_term
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit0, fw_log__emit2, fw_sysassert_fatal, get_reg_880b80, set_g_800100, u_schd__cancel, u_schd__schedule
 * Глобалы (через gp): 0x8003ac
 */
	.section .text.schedule_long_term_trigger,"ax",@progbits
	.global schedule_long_term_trigger
schedule_long_term_trigger:
	.global L_8dfa80
L_8dfa80:
	push_s blink
L_8dfa82:
	bl L_8c02bc
L_8dfa86:
	mov_s r13,r0
L_8dfa88:
	ld_s r0,[gp,-0x6c]
L_8dfa8a:
	mov_s r16,r1
L_8dfa8c:
	brne r0,0x0,L_8dfb66
L_8dfa90:
	cmp_s r2,0x5
L_8dfa92:
	mov_s r15,0x5
L_8dfa94:
	ld_s r0,[gp,0x23c]
L_8dfa96:
	mov.cs r15,r2
L_8dfa9a:
	breq r0,0x0,L_8dfb66
L_8dfa9e:
	mov_s r0,0x80345c
L_8dfaa4:
	ld_s r0,[r0,0xc]
L_8dfaa6:
	brne r0,0x0,L_8dfb66
L_8dfaaa:
	brhs r16,0xd,L_8dfb40
	.global L_8dfaae
L_8dfaae:
	ld_s r0,[r13,0x40]
L_8dfab0:
	mov_s r14,0x0
L_8dfab2:
	breq_s r0,0,L_8dfaba
L_8dfab4:
	bl L_8c7794
L_8dfab8:
	st_s r14,[r13,0x40]
	.global L_8dfaba
L_8dfaba:
	mov_s r14,0x8013d0
L_8dfac0:
	ldw_s r1,[r14,0x24]
L_8dfac2:
	ldw_s r0,[r14,0x22]
L_8dfac4:
	asl_s r1,r1,0x10
L_8dfac6:
	or_s r0,r0,r1
L_8dfac8:
	norm r0,r0
L_8dfacc:
	rsub r3,r0,0x1e
L_8dfad0:
	mov_s r2,0x1011d7c
L_8dfad6:
	mov_s r0,0x0
L_8dfad8:
	mov_s r1,0x2
L_8dfada:
	bl.d L_8edff8
L_8dfade:
	mov r4,r16
L_8dfae2:
	ldw_s r1,[r14,0x24]
L_8dfae4:
	ldw_s r0,[r14,0x22]
L_8dfae6:
	asl_s r1,r1,0x10
L_8dfae8:
	or_s r0,r0,r1
L_8dfaea:
	norm r0,r0
L_8dfaee:
	rsub r1,r0,0x1e
L_8dfaf2:
	breq r1,r16,L_8dfb58
L_8dfaf6:
	mov_s r0,0x801354
L_8dfafc:
	ld.as r0,[r0,r16]
L_8dfb00:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8dfb02:
	mulu64 r0,r15
L_8dfb06:
	mov_s r14,mlo
L_8dfb08:
	bl.d L_8e3580
L_8dfb0c:
	mov_s r0,0x0
L_8dfb0e:
	bmsk_s r0,r0,0x3
L_8dfb10:
	/* mulu64 r0,0xbb8 */
	.byte 0x05,0x28,0x80,0x0f,0x00,0x00,0xb8,0x0b
L_8dfb18:
	add_s r14,r14,mlo
L_8dfb1a:
	bl.d L_8de5d0
L_8dfb1e:
	add3 r0,r13,0xa
L_8dfb22:
	mov_s r0,0x16aec
L_8dfb28:
	mov_s r1,r13
L_8dfb2a:
	mov_s r2,0x0
L_8dfb2c:
	mov_s r3,0x0
L_8dfb2e:
	mov_s r4,r14
L_8dfb30:
	mov r5,0x0
L_8dfb34:
	bl.d L_8dc92c
L_8dfb38:
	mov r6,0x0
L_8dfb3c:
	st_s r0,[r13,0x40]
L_8dfb3e:
	b_s L_8dfb66
	.global L_8dfb40
L_8dfb40:
	mov_s r0,blink
L_8dfb42:
	mov_s r2,0x1011d6c
L_8dfb48:
	mov_s r1,0x126d
L_8dfb4e:
	bl.d L_8c82c0
L_8dfb52:
	mov r3,0x29f
L_8dfb56:
	b_s L_8dfaae
	.global L_8dfb58
L_8dfb58:
	mov_s r2,0x1011db4
L_8dfb5e:
	mov_s r0,0x0
L_8dfb60:
	bl.d L_8edfb0
L_8dfb64:
	mov_s r1,0x2
	.global L_8dfb66
L_8dfb66:
	b L_8c0324
L_8dfb6a:
	nop_s
