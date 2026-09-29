/* bf_sm__release_sta @ 0x9224c4, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_flow_step, txss_flow_step_b
 * Зовёт сам: __ld_r13_ret_uc, bf_pending__set_bit, bi_tx__check_idle_and_start, mid_vring_mask_update, rate_search__reset_sta, tbl_8018b5__byte_by_index, uc_pending__clear_bit
 * Глобалы (через gp): 0x800604, 0x800608
 */
	.section .text.bf_sm__release_sta,"ax",@progbits
	.global bf_sm__release_sta
bf_sm__release_sta:
	.global L_9224c4
L_9224c4:
	push_s blink
L_9224c6:
	push_s r13
L_9224c8:
	bl.d L_92c320
L_9224cc:
	mov_s r13,r0
L_9224ce:
	cmp_s r0,0x0
L_9224d0:
	bl.eq.d L_92bd80
L_9224d4:
	mov.eq r0,r13
L_9224d8:
	bl.d L_928f6c
L_9224dc:
	mov_s r0,0x3
L_9224de:
	mov_s r0,0x3
L_9224e0:
	bl.d L_928cb4
L_9224e4:
	mov_s r1,r13
L_9224e6:
	bl.d L_931a78
L_9224ea:
	mov_s r0,0x2
L_9224ec:
	bl.d L_921f58
L_9224f0:
	mov_s r0,0x0
L_9224f2:
	mov_s r0,0x0
L_9224f4:
	st.as r0,[gp,0x37]
L_9224f8:
	b.d L_92028c
L_9224fc:
	st.as r0,[gp,0x38]
