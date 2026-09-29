/* pm__event_mask_restore @ 0x92a69c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pm__wake_sequence
 * Зовёт сам: __ld_r13_ret_uc, mac__program_rf_mode
 */
	.section .text.pm__event_mask_restore,"ax",@progbits
	.global pm__event_mask_restore
pm__event_mask_restore:
	.global L_92a69c
L_92a69c:
	push_s blink
L_92a69e:
	push_s r13
L_92a6a0:
	mov_s r1,0x800994
L_92a6a6:
	ld_s r0,[r1]
L_92a6a8:
	bbit0 r0,0x0,L_92a6e2
L_92a6ac:
	ld_s r0,[r1,0xc]
L_92a6ae:
	st_s r0,[r1,0x8]
L_92a6b0:
	lr r13,[0xa]
L_92a6b4:
	bclr r0,r13,0x1
L_92a6b8:
	flag r0
L_92a6bc:
	ld_s r0,[gp,-0xd8]
L_92a6be:
	ld_s r1,[r1,0x8]
L_92a6c0:
	and_s r0,r0,r1
L_92a6c2:
	bset_s r0,r0,0x1b
L_92a6c4:
	mov_s r32,r0
L_92a6c6:
	st.ab r0,[r25,0x4]
L_92a6ca:
	bclr r25,r25,0xa
L_92a6ce:
	bl.d L_9296c8
L_92a6d2:
	mov_s r0,0x1
L_92a6d4:
	lr r0,[0xa]
L_92a6d8:
	bic r13,r13,-0x3
L_92a6dc:
	or_s r13,r13,r0
L_92a6de:
	flag r13
	.global L_92a6e2
L_92a6e2:
	mov r1,-0x1
L_92a6e6:
	mov_s r0,0x800994
L_92a6ec:
	b.d L_92028c
L_92a6f0:
	st_s r1,[r0,0xc]
L_92a6f2:
	nop_s
