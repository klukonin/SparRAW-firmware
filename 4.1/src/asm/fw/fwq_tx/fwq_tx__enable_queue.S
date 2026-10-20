/* fwq_tx__enable_queue @ 0x8e2624, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwq_tx.cpp
 * Зовут его: fwq_tx__init, rm_ch_switch__resume_tx_queue
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, fwq_tx__check_prio, fwq_tx__send_next
 */
	.section .text.fwq_tx__enable_queue,"ax",@progbits
	.global fwq_tx__enable_queue
fwq_tx__enable_queue:
	.global L_8e2624
L_8e2624:
	push_s blink
L_8e2626:
	bl L_8c02c4
L_8e262a:
	mov_s r13,r0
L_8e262c:
	ld_s r0,[r0,0x8]
L_8e262e:
	mov_s r14,r1
L_8e2630:
	brne_s r0,0,L_8e2650
	.global L_8e2632
L_8e2632:
	mov_s r0,0x1
L_8e2634:
	st_s r0,[r13,0x8]
L_8e2636:
	st_s r14,[r13,0xc]
L_8e2638:
	mov_s r0,r13
L_8e263a:
	bl.d L_8c9b10
L_8e263e:
	mov_s r1,r14
L_8e2640:
	st_s r0,[r13,0x30]
L_8e2642:
	mov_s r0,0x0
L_8e2644:
	st_s r0,[r13,0x14]
L_8e2646:
	bl.d L_8e0a28
L_8e264a:
	mov_s r0,r13
L_8e264c:
	b L_8c0334
	.global L_8e2650
L_8e2650:
	mov_s r0,blink
L_8e2652:
	mov_s r2,0x1015730
L_8e2658:
	mov_s r1,0x120d
L_8e265e:
	bl.d L_8c82c0
L_8e2662:
	mov_s r3,0x1a
L_8e2664:
	b_s L_8e2632
L_8e2666:
	nop_s
