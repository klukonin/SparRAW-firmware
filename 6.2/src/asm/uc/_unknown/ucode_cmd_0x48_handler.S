/* ucode_cmd_0x48_handler @ 0x927618, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, irq_safe__deref_field_04, memset0_words_uc, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x48_handler
ucode_cmd_0x48_handler:
	.global L_927618
L_927618:
	push_s blink
L_92761a:
	mov_s r0,0x802470
L_927620:
	bl.d L_920d4c
L_927624:
	push_s r13
L_927626:
	mov_s r13,0x800814
L_92762c:
	ldw_s r1,[r13]
L_92762e:
	stw_s r1,[r0]
L_927630:
	ldw_s r1,[r13,0x2]
L_927632:
	stw_s r1,[r0,0x2]
L_927634:
	ldw_s r1,[r13,0x6]
L_927636:
	ldw_s r2,[r13,0x4]
L_927638:
	sub_s r1,r1,r2
L_92763a:
	stw_s r1,[r0,0x4]
L_92763c:
	ldw_s r1,[r13,0x8]
L_92763e:
	mov_s r2,0xe
L_927640:
	stw_s r1,[r0,0x6]
L_927642:
	ldw_s r1,[r13,0xa]
L_927644:
	stw_s r1,[r0,0x8]
L_927646:
	ldw_s r1,[r13,0xc]
L_927648:
	stw_s r1,[r0,0xa]
L_92764a:
	ldw_s r1,[r13,0xe]
L_92764c:
	stw_s r1,[r0,0xc]
L_92764e:
	mov_s r1,0x2f
L_927650:
	bl.d L_927958
L_927654:
	mov_s r3,0x0
L_927656:
	mov_s r0,r13
L_927658:
	bl.d L_920a84
L_92765c:
	mov_s r1,0x10
L_92765e:
	b L_9202ac
L_927662:
	nop_s
