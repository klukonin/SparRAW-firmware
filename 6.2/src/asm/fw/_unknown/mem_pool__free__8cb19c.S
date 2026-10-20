/* mem_pool__free__8cb19c @ 0x8cb19c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mem_pool__free_thunk, wmi_evt__alloc_and_fill
 * Зовёт сам: __ld_r13_to_r13_ret, mem_pool__put_block, stream_mgr__check_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mem_pool__free__8cb19c
mem_pool__free__8cb19c:
	.global L_8cb19c
L_8cb19c:
	push_s blink
L_8cb19e:
	push_s r13
L_8cb1a0:
	mov_s r1,r0
L_8cb1a2:
	mov_s r13,0x805fe4
L_8cb1a8:
	bl.d L_8caed0
L_8cb1ac:
	add r0,r13,0x1c
L_8cb1b0:
	bl.d L_8c6414
L_8cb1b4:
	mov_s r0,r13
L_8cb1b6:
	b L_8c025c
L_8cb1ba:
	nop_s
