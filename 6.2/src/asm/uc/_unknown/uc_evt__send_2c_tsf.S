/* uc_evt__send_2c_tsf @ 0x927700, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: handle_pmc_triggers
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, irq_safe__deref_field_04, uc_evt__enqueue, uc_read_tsf_lo
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__send_2c_tsf
uc_evt__send_2c_tsf:
	.global L_927700
L_927700:
	push_s blink
L_927702:
	bl L_92022c
L_927706:
	mov_s r14,r0
L_927708:
	mov_s r15,r1
L_92770a:
	mov_s r0,0x802470
L_927710:
	bl.d L_920d4c
L_927714:
	mov_s r16,r2
L_927716:
	mov_s r13,r0
L_927718:
	st_s r14,[r0]
L_92771a:
	bl.d L_9364c8
L_92771e:
	st r16,[r0, 0x4]
L_927722:
	st_s r0,[r13,0x8]
L_927724:
	st_s r15,[r13,0xc]
L_927726:
	mov_s r0,r13
L_927728:
	mov_s r1,0x2c
L_92772a:
	mov_s r2,0x10
L_92772c:
	bl.d L_927958
L_927730:
	mov_s r3,0x0
L_927732:
	b L_920294
L_927736:
	nop_s
