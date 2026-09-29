/* mid__lookup_at_48 @ 0x8eaab0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__lookup_step
 * Зовёт сам: __ld_r13_to_r13_ret, app_ie__find_by_eid, ba_sm__lookup_stream, mid__get_bcon_additional_ies
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__lookup_at_48
mid__lookup_at_48:
	.global L_8eaab0
L_8eaab0:
	push_s blink
L_8eaab2:
	push_s r13
L_8eaab4:
	mov_s r13,r0
L_8eaab6:
	add_s r0,r0,0x48
L_8eaab8:
	bl.d L_8cb844
L_8eaabc:
	mov_s r1,0x8
L_8eaabe:
	bl.d L_8cc2b8
L_8eaac2:
	mov_s r1,0x90
L_8eaac4:
	mov.f r1,r0
L_8eaac8:
	beq_s L_8eaad2
L_8eaaca:
	bl.d L_8eaad8
L_8eaace:
	ld.as r0,[r13,0xa4]
	.global L_8eaad2
L_8eaad2:
	b L_8c025c
L_8eaad6:
	nop_s
