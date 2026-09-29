/* fwq_tx__enable_queue @ 0x8e787c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__init, rm_ch_switch__resume_tx_queue
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, brd_if_multi_array__get_chunk_8cbbc4, fw_sysassert_fatal, fwq_tx__queue_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__enable_queue
fwq_tx__enable_queue:
	.global L_8e787c
L_8e787c:
	push_s blink
L_8e787e:
	bl L_8c01e4
L_8e7882:
	mov_s r13,r0
L_8e7884:
	ld_s r0,[r0,0x8]
L_8e7886:
	mov_s r14,r1
L_8e7888:
	brne_s r0,0,L_8e78a8
	.global L_8e788a
L_8e788a:
	mov_s r0,0x1
L_8e788c:
	st_s r0,[r13,0x8]
L_8e788e:
	st_s r14,[r13,0xc]
L_8e7890:
	mov_s r0,r13
L_8e7892:
	bl.d L_8cbbc4
L_8e7896:
	mov_s r1,r14
L_8e7898:
	st_s r0,[r13,0x30]
L_8e789a:
	mov_s r0,0x0
L_8e789c:
	st_s r0,[r13,0x14]
L_8e789e:
	bl.d L_8e5620
L_8e78a2:
	mov_s r0,r13
L_8e78a4:
	b L_8c0254
	.global L_8e78a8
L_8e78a8:
	mov_s r0,blink
L_8e78aa:
	mov_s r1,0x120d
L_8e78b0:
	bl L_8c9b28
L_8e78b4:
	b_s L_8e788a
L_8e78b6:
	nop_s
