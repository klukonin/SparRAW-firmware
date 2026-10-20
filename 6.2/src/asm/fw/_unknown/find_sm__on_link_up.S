/* find_sm__on_link_up @ 0x8c48c4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: Link up....
 * Зовут его: handle_abft_event, l2mgr__notify_link_up
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_sm__on_link_up
find_sm__on_link_up:
	.global L_8c48c4
L_8c48c4:
	push_s blink
L_8c48c6:
	bl L_8c01e0
L_8c48ca:
	mov_s r13,r0
L_8c48cc:
	ld_s r0,[r0,0x40]
L_8c48ce:
	mov_s r15,r1
L_8c48d0:
	mov_s r14,r2
L_8c48d2:
	breq_s r0,0,L_8c48f2
L_8c48d4:
	mov_s r1,0x1017960
L_8c48da:
	bl.d L_8dcba8
L_8c48de:
	mov_s r0,0x2c
L_8c48e0:
	add r0,r13,0x1c
L_8c48e4:
	mov_s r1,0x5
L_8c48e6:
	mov_s r2,r15
L_8c48e8:
	mov_s r3,r14
L_8c48ea:
	bl.d L_8d9b6c
L_8c48ee:
	mov r4,0x0
	.global L_8c48f2
L_8c48f2:
	b L_8c024c
L_8c48f6:
	nop_s
