/* l1_task__mask_wake_req_and_defer @ 0x9274f4, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Зовёт сам: bf_pending__set_bit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_task__mask_wake_req_and_defer
l1_task__mask_wake_req_and_defer:
	.global L_9274f4
L_9274f4:
	mov_s r1,0x4
L_9274f6:
	mov_s r0,0x886d80
L_9274fc:
	st_s r1,[r0,0x60]
L_9274fe:
	sync
L_927502:
	b.d L_9216f8
L_927506:
	mov_s r0,0x4
