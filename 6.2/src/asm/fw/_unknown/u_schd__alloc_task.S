/* u_schd__alloc_task @ 0x8c32f8, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__add, u_schd__insert_timer
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, mem_pool__allocate, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__alloc_task
u_schd__alloc_task:
	.global L_8c32f8
L_8c32f8:
	push_s blink
L_8c32fa:
	bl L_8c01e4
L_8c32fe:
	lr r14,[0xa]
L_8c3302:
	bclr r0,r14,0x1
L_8c3306:
	flag r0
L_8c330a:
	mov_s r0,0x803c80
L_8c3310:
	bl.d L_8c354c
L_8c3314:
	bic r14,r14,-0x3
L_8c3318:
	mov_s r13,r0
L_8c331a:
	lr r0,[0xa]
L_8c331e:
	or_s r14,r14,r0
L_8c3320:
	flag r14
L_8c3324:
	breq_s r13,0,L_8c3334
	.global L_8c3326
L_8c3326:
	mov_s r0,r13
L_8c3328:
	bl.d L_8c1cd8
L_8c332c:
	mov_s r1,0x1c
L_8c332e:
	b.d L_8c0254
L_8c3332:
	mov_s r0,r13
	.global L_8c3334
L_8c3334:
	mov_s r0,blink
L_8c3336:
	mov_s r1,0x63
L_8c3338:
	bl.d L_8c9b28
L_8c333c:
	bset_s r1,r1,0xc
L_8c333e:
	b_s L_8c3326
