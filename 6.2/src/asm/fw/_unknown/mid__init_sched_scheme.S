/* mid__init_sched_scheme @ 0x8d96fc, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__open
 * Зовёт сам: __ld_r13_to_r13_ret, bits__set32_s4_w3, memset0_words, mid__program_88c068, mid__reset_sched_alloc_regs, mid__sched_scheme_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__init_sched_scheme
mid__init_sched_scheme:
	.global L_8d96fc
L_8d96fc:
	push_s blink
L_8d96fe:
	push_s r13
L_8d9700:
	mov_s r13,r0
L_8d9702:
	bl.d L_8ccb74
L_8d9706:
	st_s r1,[r0,0x10]
L_8d9708:
	st_s r0,[r13]
L_8d970a:
	mov_s r13,0x805234
L_8d9710:
	add r0,r13,0x1c
L_8d9714:
	bl.d L_8c1cd8
L_8d9718:
	mov_s r1,0xf
L_8d971a:
	mov_s r2,0x1
L_8d971c:
	add r0,r13,0x1c
L_8d9720:
	mov_s r1,r2
L_8d9722:
	bl L_8ed514
L_8d9726:
	ld_s r0,[r13,0x1c]
L_8d9728:
	bset_s r0,r0,0x7
L_8d972a:
	st_s r0,[r13,0x1c]
L_8d972c:
	bl.d L_8d0e48
L_8d9730:
	stb r2,[r13, 0x28]
L_8d9734:
	bl L_8d0e14
L_8d9738:
	b L_8c025c
