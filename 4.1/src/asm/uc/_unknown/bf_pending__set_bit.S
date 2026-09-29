/* bf_pending__set_bit @ 0x921f58, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__clear_pending, bf_sm__release_sta, bf_sm__substate_advance, internal_tx__pending_sm, set_reg_886d80_925b34, set_reg_886d80_925b48, tx_initiator_step, umac_if_cmd_handler
 */
	.section .text.bf_pending__set_bit,"ax",@progbits
	.global bf_pending__set_bit
bf_pending__set_bit:
	.global L_921f58
L_921f58:
	lr r2,[0xa]
L_921f5c:
	bclr r1,r2,0x1
L_921f60:
	flag r1
L_921f64:
	mov_s r3,0x800630
L_921f6a:
	ld_s r1,[r3]
L_921f6c:
	bic r2,r2,-0x3
L_921f70:
	bset r1,r1,r0
L_921f74:
	st_s r1,[r3]
L_921f76:
	lr r0,[0xa]
L_921f7a:
	or_s r2,r2,r0
L_921f7c:
	flag r2
L_921f80:
	j_s [blink]
L_921f82:
	nop_s
