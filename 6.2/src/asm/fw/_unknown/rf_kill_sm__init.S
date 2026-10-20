/* rf_kill_sm__init @ 0x8d8bc0, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Initializing RF_KILL_SM with W_DISABLE
 * Зовут его: l2mgr__on_lmac_ready
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__bind_descriptor, basic_sm__handle_event, fw_log_emit0, mac__toggle_880288_b1, rf_kill__ack_irq, rf_kill__mask_irq, rf_kill__unmask_irq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_kill_sm__init
rf_kill_sm__init:
	.global L_8d8bc0
L_8d8bc0:
	push_s blink
L_8d8bc2:
	push_s r13
L_8d8bc4:
	mov_s r1,0x802338
L_8d8bca:
	bl.d L_8d94e0
L_8d8bce:
	mov_s r13,r0
L_8d8bd0:
	mov_s r0,0x880a3c
L_8d8bd6:
	ld_s r0,[r0,0x58]
L_8d8bd8:
	bbit0 r0,0x0,L_8d8c12
L_8d8bdc:
	bl.d L_8c7044
L_8d8be0:
	mov_s r0,r13
L_8d8be2:
	mov_s r0,0x880280
L_8d8be8:
	ld_s r0,[r0,0x8]
L_8d8bea:
	bbit1 r0,0x0,L_8d8c08
L_8d8bee:
	mov_s r1,0x100ba50
L_8d8bf4:
	bl.d L_8dcba8
L_8d8bf8:
	mov_s r0,0x20
L_8d8bfa:
	mov_s r0,r13
L_8d8bfc:
	mov_s r1,0x1
L_8d8bfe:
	mov_s r2,0x0
L_8d8c00:
	mov_s r3,r2
L_8d8c02:
	bl.d L_8d9b6c
L_8d8c06:
	mov_s r4,r2
	.global L_8d8c08
L_8d8c08:
	bl L_8c0744
L_8d8c0c:
	bl L_8c1604
L_8d8c10:
	b_s L_8d8c16
	.global L_8d8c12
L_8d8c12:
	bl L_8c14bc
	.global L_8d8c16
L_8d8c16:
	b L_8c025c
L_8d8c1a:
	nop_s
