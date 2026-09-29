/* rx_buf__alloc @ 0x8c3394, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion, rx_api__drain_all_lists
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, mem_pool__allocate
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_buf__alloc
rx_buf__alloc:
	.global L_8c3394
L_8c3394:
	push_s blink
L_8c3396:
	bl L_8c01e4
L_8c339a:
	sub_s sp,sp,0xc
L_8c339c:
	mov_s r0,0x806000
L_8c33a2:
	bl.d L_8c354c
L_8c33a6:
	mov_s r13,sp
L_8c33a8:
	mov.f r14,r0
L_8c33ac:
	beq_s L_8c33c2
	.global L_8c33ae
L_8c33ae:
	st_s r14,[r13]
L_8c33b0:
	add r0,r14,0x28
L_8c33b4:
	st_s r0,[r13,0x8]
L_8c33b6:
	add_s r14,r14,0x38
L_8c33b8:
	st_s r14,[r13,0x4]
L_8c33ba:
	ld_s r0,[sp,0x4]
L_8c33bc:
	b.d L_8c0254
L_8c33c0:
	add_s sp,sp,0xc
	.global L_8c33c2
L_8c33c2:
	mov_s r0,blink
L_8c33c4:
	mov_s r1,0x1
L_8c33c6:
	bl.d L_8c9b28
L_8c33ca:
	bset_s r1,r1,0xc
L_8c33cc:
	b_s L_8c33ae
L_8c33ce:
	nop_s
