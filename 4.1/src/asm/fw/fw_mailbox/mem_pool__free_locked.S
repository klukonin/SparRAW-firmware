/* mem_pool__free_locked @ 0x8c93f4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__cancel, u_schd__large_task_warn
 * Зовёт сам: __ld_r13_ret, mem_pool__free, obj__clear_f24
 */
	.section .text.mem_pool__free_locked,"ax",@progbits
	.global mem_pool__free_locked
mem_pool__free_locked:
	.global L_8c93f4
L_8c93f4:
	push_s blink
L_8c93f6:
	push_s r13
L_8c93f8:
	bl.d L_8c92fc
L_8c93fc:
	mov_s r2,r0
L_8c93fe:
	lr r13,[0xa]
L_8c9402:
	bclr r0,r13,0x1
L_8c9406:
	flag r0
L_8c940a:
	mov_s r0,0x8034d4
L_8c9410:
	bl.d L_8c9268
L_8c9414:
	mov_s r1,r2
L_8c9416:
	lr r0,[0xa]
L_8c941a:
	bic r13,r13,-0x3
L_8c941e:
	or_s r13,r13,r0
L_8c9420:
	flag r13
L_8c9424:
	b L_8c033c
