/* sends_pmc_mark_aaab02 @ 0x93cc40, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow_step
 * Зовёт сам: __ld_r13_to_r13_ret, fixed_sched__slot_cfg_u16_2, fixed_sched__slot_setup, fsched__slot_half4, handle_pmc_triggers
 * Глобалы (через gp): 0x80064c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sends_pmc_mark_aaab02
sends_pmc_mark_aaab02:
	.global L_93cc40
L_93cc40:
	push_s blink
L_93cc42:
	push_s r13
L_93cc44:
	mov_s r3,r0
L_93cc46:
	ld_s r0,[gp,0x124]
L_93cc48:
	mov_s r13,r1
L_93cc4a:
	brne r0,0x4,L_93cc88
L_93cc4e:
	ldb r0,[r3, 0x2d]
L_93cc52:
	breq_s r0,0,L_93cc88
L_93cc54:
	bl.d L_927d5c
L_93cc58:
	mov_s r0,r3
L_93cc5a:
	mov_s r2,r0
L_93cc5c:
	bl.d L_927d94
L_93cc60:
	mov_s r0,r3
L_93cc62:
	sub_s r2,r2,r0
L_93cc64:
	brhs r13,r2,L_93cc88
L_93cc68:
	bl.d L_93cc24
L_93cc6c:
	mov_s r0,r3
L_93cc6e:
	mov r0,-0x1
L_93cc72:
	bl.d L_9289c0
L_93cc76:
	mov_s r1,0x0
L_93cc78:
	mov_s r0,0x80aaab02
L_93cc7e:
	mov_s r32,r0
L_93cc80:
	st.ab r0,[r25,0x4]
L_93cc84:
	bclr r25,r25,0xa
	.global L_93cc88
L_93cc88:
	b L_9202ac
