/* l1_task__mask_halt_req_and_defer @ 0x9274e0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Зовёт сам: bf_pending__set_bit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_task__mask_halt_req_and_defer
l1_task__mask_halt_req_and_defer:
	.global L_9274e0
L_9274e0:
	mov_s r1,0x2
L_9274e2:
	mov_s r0,0x886d80
L_9274e8:
	st_s r1,[r0,0x60]
L_9274ea:
	sync
L_9274ee:
	b.d L_9216f8
L_9274f2:
	mov_s r0,0x3
