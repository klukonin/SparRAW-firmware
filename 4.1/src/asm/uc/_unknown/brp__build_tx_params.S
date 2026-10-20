/* brp__build_tx_params @ 0x92ab1c, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_flow_step, mac_mode_brp_step, mac_mode_step_b
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf_w_s4_w5_uc
 * Глобалы (через gp): 0x8005d0, 0x8005d2
 */
	.section .text.brp__build_tx_params,"ax",@progbits
	.global brp__build_tx_params
brp__build_tx_params:
	.global L_92ab1c
L_92ab1c:
	push_s blink
L_92ab1e:
	bl.d L_920210
L_92ab22:
	mov_s r3,r0
L_92ab24:
	sub_s sp,sp,0x4
L_92ab26:
	mov_s r0,0x0
L_92ab28:
	mov_s r1,0x804010
L_92ab2e:
	ldb r13,[r1, 0x21]
L_92ab32:
	ldb r2,[r1, 0x20]
L_92ab36:
	asl_s r13,r13,0x8
L_92ab38:
	or_s r2,r2,r13
L_92ab3a:
	lsr r13,r2,0xa
L_92ab3e:
	ldw_s r14,[r1,0x24]
L_92ab40:
	bmsk_s r13,r13,0x0
L_92ab42:
	lsr_s r14,r14,0xa
L_92ab44:
	bmsk_s r14,r14,0x0
L_92ab46:
	ldb_s r1,[r1,0x1b]
L_92ab48:
	/* asl_s r14,r14,0x3 */
	.byte 0x03,0xbe
L_92ab4a:
	lsr r15,r1,0x5
L_92ab4e:
	bmsk_s r15,r15,0x0
L_92ab50:
	asl_s r15,r15
L_92ab52:
	bclr_s r13,r13,0x1
L_92ab54:
	bclr_s r14,r14,0x1
L_92ab56:
	bmsk.f 0x0,r1,0x4
L_92ab5a:
	or_s r13,r13,r14
L_92ab5c:
	or_s r13,r13,r15
L_92ab5e:
	beq_s L_92ab66
L_92ab60:
	btst_s r13,0x3
L_92ab62:
	mov.eq r0,0x1
	.global L_92ab66
L_92ab66:
	bmsk_s r0,r0,0x0
L_92ab68:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92ab6a:
	bclr_s r13,r13,0x2
L_92ab6c:
	or_s r13,r13,r0
L_92ab6e:
	bmsk_s r1,r1,0x4
L_92ab70:
	mov_s r0,sp
L_92ab72:
	bl.d L_9379dc
L_92ab76:
	st_s r13,[sp,0x0]
L_92ab78:
	extb.f 0x0,r2
L_92ab7c:
	mov_s r1,0x0
L_92ab7e:
	bset r1,r1,r3
L_92ab82:
	ldw_s r0,[gp,0xaa]
L_92ab84:
	beq_s L_92ab90
L_92ab86:
	mov_s r2,0x857280
L_92ab8c:
	ld_s r2,[r2,0x24]
L_92ab8e:
	breq_s r2,0,L_92ab94
	.global L_92ab90
L_92ab90:
	bic_s r0,r0,r1
L_92ab92:
	b_s L_92ab96
	.global L_92ab94
L_92ab94:
	or_s r0,r0,r1
	.global L_92ab96
L_92ab96:
	stw.as r0,[gp,0x55]
L_92ab9a:
	ldw_s r0,[gp,0xa8]
L_92ab9c:
	or_s r0,r0,r1
L_92ab9e:
	stw.as r0,[gp,0x54]
L_92aba2:
	ld_s r0,[sp,0x0]
L_92aba4:
	b.d L_92027c
L_92aba8:
	add_s sp,sp,0x4
L_92abaa:
	nop_s
