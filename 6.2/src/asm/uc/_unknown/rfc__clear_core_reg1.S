/* rfc__clear_core_reg1 @ 0x929f94, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__init_ctx, brp_initiator_brp_transaction_flow, brp_initiator_flow_successful_receive_training, brp_responder_flow_enter
 * Зовёт сам: hwd_rfc_write_core
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rfc__clear_core_reg1
rfc__clear_core_reg1:
	.global L_929f94
L_929f94:
	mov_s r1,0x1
L_929f96:
	mov_s r2,0x0
L_929f98:
	b.d L_92a3d8
L_929f9c:
	mov_s r3,r2
L_929f9e:
	nop_s
