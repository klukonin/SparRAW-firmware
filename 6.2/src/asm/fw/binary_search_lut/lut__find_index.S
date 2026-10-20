/* lut__find_index @ 0x8c74e8, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lut::find_index(): Trying to use not initialized LUT
 * Зовут его: sysapi_mgr__stats_lut_find_index
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_sysassert_fatal, lut__find_index__2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lut__find_index
lut__find_index:
	.global L_8c74e8
L_8c74e8:
	push_s blink
L_8c74ea:
	bl L_8c01e4
L_8c74ee:
	mov_s r14,r0
L_8c74f0:
	ld_s r0,[r0]
L_8c74f2:
	mov_s r13,r1
L_8c74f4:
	breq_s r0,0,L_8c74fa
L_8c74f6:
	ld_s r0,[r14,0x4]
L_8c74f8:
	brne_s r0,0,L_8c7514
	.global L_8c74fa
L_8c74fa:
	mov_s r1,0x101321c
L_8c7500:
	bl.d L_8dcba8
L_8c7504:
	mov_s r0,0x0
L_8c7506:
	mov_s r0,blink
L_8c7508:
	mov_s r1,0x1512
L_8c750e:
	bl L_8c9b28
L_8c7512:
	b_s L_8c7520
	.global L_8c7514
L_8c7514:
	bl.d L_8ca7f8
L_8c7518:
	mov_s r0,r14
L_8c751a:
	ld_s r1,[r14,0x4]
L_8c751c:
	ld.as r13,[r1,r0]
	.global L_8c7520
L_8c7520:
	b.d L_8c0254
L_8c7524:
	mov_s r0,r13
L_8c7526:
	nop_s
