/* bf__enter_mode3 @ 0x9218f4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__substate_result_by_slot, bf_substate_sm__step
 * Зовёт сам: __ld_r13_ret_uc, mid_vring_mask_update, uc_res_886f00__acquire
 */
	.section .text.bf__enter_mode3,"ax",@progbits
	.global bf__enter_mode3
bf__enter_mode3:
	.global L_9218f4
L_9218f4:
	push_s blink
L_9218f6:
	push_s r13
L_9218f8:
	mov_s r13,r1
L_9218fa:
	st.as r1,[gp,-0x2f]
L_9218fe:
	bl.d L_928f2c
L_921902:
	mov_s r0,0x3
L_921904:
	mov_s r0,0x3
L_921906:
	bl.d L_928cb4
L_92190a:
	mov_s r1,r13
L_92190c:
	b L_92028c
