/* internal_tx__clear_pending @ 0x933d78, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx_step, umac_if_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, uc_pending__clear_bit, uc_res_vote__release
 * Глобалы (через gp): 0x800574
 */
	.section .text.internal_tx__clear_pending,"ax",@progbits
	.global internal_tx__clear_pending
internal_tx__clear_pending:
	.global L_933d78
L_933d78:
	push_s blink
L_933d7a:
	bl L_920214
L_933d7e:
	mov_s r13,r0
L_933d80:
	lr r14,[0xa]
L_933d84:
	bclr r0,r14,0x1
L_933d88:
	flag r0
L_933d8c:
	ld_s r0,[gp,0x4c]
L_933d8e:
	breq_s r0,0,L_933d98
L_933d90:
	bclr r0,r0,r13
L_933d94:
	st.as r0,[gp,0x13]
	.global L_933d98
L_933d98:
	brne_s r0,0,L_933da6
L_933d9a:
	bl.d L_928f6c
L_933d9e:
	mov_s r0,0x2
L_933da0:
	bl.d L_928df4
L_933da4:
	mov_s r0,0x2
	.global L_933da6
L_933da6:
	lr r0,[0xa]
L_933daa:
	bic r14,r14,-0x3
L_933dae:
	or_s r14,r14,r0
L_933db0:
	flag r14
L_933db4:
	ld_s r0,[gp,0x4c]
L_933db6:
	mov_s r1,0x857180
L_933dbc:
	brhs.d r13,0x8,L_933dd2
L_933dc0:
	st_s r0,[r1,0x5c]
L_933dc2:
	mov_s r1,0x0
L_933dc4:
	asl_s r0,r13,0x2
L_933dc6:
	add2_s r0,r0,r0
L_933dc8:
	add_s r0,r0,0x857838
L_933dce:
	stb_s r1,[r0,0x7]
L_933dd0:
	stb_s r1,[r0,0x9]
	.global L_933dd2
L_933dd2:
	b L_920284
L_933dd6:
	nop_s
