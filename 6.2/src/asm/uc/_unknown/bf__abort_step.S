/* bf__abort_step @ 0x921824, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__abort_unexpected, bf_init_sm, bf_req__dequeue_head, bf_sm__process_request_fifo, l1_task__select_by_mode, ucode_cmd_0x31_handler
 * Зовёт сам: __ld_r13_to_r13_ret, bf__abort_noop_hook, bf_pending__set_bit, peer_masks__or_sta_bit_into_8571c4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__abort_step
bf__abort_step:
	.global L_921824
L_921824:
	push_s blink
L_921826:
	push_s r13
L_921828:
	mov_s r13,r0
L_92182a:
	bl.d L_9216f8
L_92182e:
	mov_s r0,0x1
L_921830:
	bl.d L_921c34
L_921834:
	mov_s r0,r13
L_921836:
	bl.d L_926ab0
L_92183a:
	mov_s r0,r13
L_92183c:
	b L_9202ac
