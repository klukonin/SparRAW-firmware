/* bi_rx__send_response @ 0x933dd8, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__rx_flow_body
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, direct_tx__program_cmd34, direct_tx_substep, mac__program_tx_with_rate
 * Глобалы (через gp): 0x800610, 0x800614
 */
	.section .text.bi_rx__send_response,"ax",@progbits
	.global bi_rx__send_response
bi_rx__send_response:
	.global L_933dd8
L_933dd8:
	push_s blink
L_933dda:
	bl L_920210
L_933dde:
	mov_s r15,r0
L_933de0:
	mov_s r13,r1
L_933de2:
	push_s r2
L_933de4:
	mov_s r14,r3
L_933de6:
	mov_s r0,0x16
L_933de8:
	bl.d L_924ea8
L_933dec:
	mov_s r1,0x18
L_933dee:
	bl.d L_92a318
L_933df2:
	mov_s r0,r13
	.global L_933df4
L_933df4:
	mov_s r0,r43
L_933df6:
	bbit0 r0,0x1f,L_933df4
L_933dfa:
	mov_s r0,r51
L_933dfc:
	bmsk r1,r0,0x3
L_933e00:
	st.as r1,[gp,0x3a]
L_933e04:
	lsr_s r0,r0,0x4
L_933e06:
	st.as r0,[gp,0x3b]
	.global L_933e0a
L_933e0a:
	mov_s r0,r45
L_933e0c:
	bbit0 r0,0x1f,L_933e0a
L_933e10:
	cmp_s r14,0x0
L_933e12:
	mov_s r0,0x18
L_933e14:
	asl.ne r0,r0,0x18
L_933e18:
	mov.eq r0,0x18002100
L_933e20:
	mov_s r32,r0
L_933e22:
	st.ab r0,[r25,0x4]
L_933e26:
	bclr r25,r25,0xa
L_933e2a:
	ld_s r1,[sp,0x0]
L_933e2c:
	mov_s r0,r15
L_933e2e:
	bl.d L_93336c
L_933e32:
	mov_s r2,r14
L_933e34:
	b.d L_92027c
L_933e38:
	add_s sp,sp,0x4
L_933e3a:
	nop_s
