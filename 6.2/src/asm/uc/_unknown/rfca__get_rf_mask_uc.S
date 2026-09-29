/* rfca__get_rf_mask_uc @ 0x928c68, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__read_rf_id, brp_init__flow, brp_initiator_flow_successful_receive_training, brp_responder_flow_enter, brp_restore_sectors, config_brp_rf, rfca__access_sector_other_rf
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rfca__get_rf_mask_uc
rfca__get_rf_mask_uc:
	.global L_928c68
L_928c68:
	ld r0,[0x889488]
L_928c70:
	lsr_s r0,r0,0x8
L_928c72:
	j_s.d [blink]
L_928c74:
	extb_s r0,r0
L_928c76:
	nop_s
