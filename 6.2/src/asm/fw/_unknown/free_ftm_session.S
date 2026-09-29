/* free_ftm_session @ 0x8cb05c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [TOF] free_ftm_session(), fail
 * Зовут его: tof_mgr, tof_mgr__clean_all_lists, tof_mgr__ftm_req_done
 * Зовёт сам: fw_log_emit0, stream_mgr__check_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global free_ftm_session
free_ftm_session:
	.global L_8cb05c
L_8cb05c:
	push_s blink
L_8cb05e:
	breq_s r1,0,L_8cb06c
L_8cb060:
	mov_s r0,0x80653c
L_8cb066:
	bl L_8caed0
L_8cb06a:
	b_s L_8cb078
	.global L_8cb06c
L_8cb06c:
	mov_s r1,0x10198ac
L_8cb072:
	bl.d L_8dcba8
L_8cb076:
	mov_s r0,0x1b
	.global L_8cb078
L_8cb078:
	pop_s blink
L_8cb07a:
	j_s [blink]
