/* sends_pmc_mark_aaab20 @ 0x92eb94, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state2
 * Зовёт сам: __ld_r13_to_r13_ret, fsched_slot__clear_f4, handle_bf_triggers
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sends_pmc_mark_aaab20
sends_pmc_mark_aaab20:
	.global L_92eb94
L_92eb94:
	push_s blink
L_92eb96:
	push_s r13
L_92eb98:
	mov_s r13,r0
L_92eb9a:
	mov_s r0,0x80aaab20
L_92eba0:
	mov_s r32,r0
L_92eba2:
	st.ab r0,[r25,0x4]
L_92eba6:
	bclr r25,r25,0xa
L_92ebaa:
	mov_s r0,0x801be8
L_92ebb0:
	bl L_924fa4
L_92ebb4:
	mov_s r0,0x8021b8
L_92ebba:
	ld_s r0,[r0,0x20]
L_92ebbc:
	bbit0 r0,0x2,L_92ebd2
L_92ebc0:
	asl_s r0,r13,0x2
L_92ebc2:
	add2_s r0,r0,r0
L_92ebc4:
	add r1,r0,0x857e38
L_92ebcc:
	ldb_s r0,[r1,0x11]
L_92ebce:
	bset_s r0,r0,0x2
L_92ebd0:
	stb_s r0,[r1,0x11]
	.global L_92ebd2
L_92ebd2:
	mov_s r0,r13
L_92ebd4:
	bl.d L_928750
L_92ebd8:
	mov_s r1,0x3
L_92ebda:
	b L_9202ac
L_92ebde:
	nop_s
