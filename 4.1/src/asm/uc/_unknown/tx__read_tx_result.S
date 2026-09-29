/* tx__read_tx_result @ 0x933e3c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: cf_end__tx_flow, internal_tx_step
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, mac__program_tx_result_ctx
 * Глобалы (через gp): 0x800610, 0x800614
 */
	.section .text.tx__read_tx_result,"ax",@progbits
	.global tx__read_tx_result
tx__read_tx_result:
	.global L_933e3c
L_933e3c:
	push_s blink
L_933e3e:
	bl L_920214
L_933e42:
	mov_s r13,r0
L_933e44:
	mov_s r14,r2
L_933e46:
	bl.d L_92a4f0
L_933e4a:
	ld_s r0,[r0,0x4]
	.global L_933e4c
L_933e4c:
	mov_s r0,r43
L_933e4e:
	bbit0 r0,0x1f,L_933e4c
L_933e52:
	mov_s r0,r51
L_933e54:
	bmsk r1,r0,0x3
L_933e58:
	st.as r1,[gp,0x3a]
L_933e5c:
	lsr_s r0,r0,0x4
L_933e5e:
	st.as r0,[gp,0x3b]
	.global L_933e62
L_933e62:
	mov_s r0,r45
L_933e64:
	bbit0 r0,0x1f,L_933e62
L_933e68:
	brne r14,0x1,L_933e7c
L_933e6c:
	mov_s r0,0x18008000
L_933e72:
	mov_s r32,r0
L_933e74:
	st.ab r0,[r25,0x4]
L_933e78:
	bclr r25,r25,0xa
	.global L_933e7c
L_933e7c:
	ld_s r1,[r13,0x14]
L_933e7e:
	extb r0,r45
L_933e82:
	and_s r0,r0,r1
L_933e84:
	cmp_s r0,0x0
L_933e86:
	mov_s r0,0x1
L_933e88:
	b.d L_920284
L_933e8c:
	sub_s.ne r0,r0,r0
L_933e8e:
	nop_s
