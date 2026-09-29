/* uc_send_evt__mac_monitor @ 0x927530, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: peer_slots__scan_by_masks
 * Зовёт сам: __ld_r13_to_r13_ret, irq_safe__deref_field_04, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_send_evt__mac_monitor
uc_send_evt__mac_monitor:
	.global L_927530
L_927530:
	push_s blink
L_927532:
	push_s r13
L_927534:
	mov_s r13,r0
L_927536:
	mov_s r0,0x802470
L_92753c:
	bl L_920d4c
L_927540:
	mov_s r1,0x17
L_927542:
	st_s r13,[r0]
L_927544:
	mov_s r2,0x4
L_927546:
	bl.d L_927958
L_92754a:
	mov_s r3,0x0
L_92754c:
	b L_9202ac
