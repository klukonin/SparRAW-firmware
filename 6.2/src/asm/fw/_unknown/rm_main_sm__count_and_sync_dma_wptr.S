/* rm_main_sm__count_and_sync_dma_wptr @ 0x8ebff8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__enter_step
 * Зовёт сам: macq_hw__sync_dma_wptr_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__count_and_sync_dma_wptr
rm_main_sm__count_and_sync_dma_wptr:
	.global L_8ebff8
L_8ebff8:
	mov_s r1,r0
L_8ebffa:
	ld_s r0,[gp,-0x100]
L_8ebffc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ebffe:
	st.as r0,[gp,-0x40]
L_8ec002:
	ldw_s r0,[r1,0x2]
L_8ec004:
	b.d L_8d4708
L_8ec008:
	ldw_s r1,[r1]
L_8ec00a:
	nop_s
