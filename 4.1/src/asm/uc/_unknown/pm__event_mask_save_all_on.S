/* pm__event_mask_save_all_on @ 0x92a630, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__open_event_mask
 * Зовёт сам: __ld_r13_ret_uc, mac__program_rf_mode
 */
	.section .text.pm__event_mask_save_all_on,"ax",@progbits
	.global pm__event_mask_save_all_on
pm__event_mask_save_all_on:
	.global L_92a630
L_92a630:
	push_s blink
L_92a632:
	push_s r13
L_92a634:
	mov_s r1,0x800994
L_92a63a:
	ld_s r0,[r1,0x8]
L_92a63c:
	st_s r0,[r1,0xc]
L_92a63e:
	mov r0,-0x1
L_92a642:
	st_s r0,[r1,0x8]
L_92a644:
	lr r13,[0xa]
L_92a648:
	bclr r0,r13,0x1
L_92a64c:
	flag r0
L_92a650:
	ld_s r0,[gp,-0xd8]
L_92a652:
	mov_s r1,0x800994
L_92a658:
	ld_s r1,[r1,0x8]
L_92a65a:
	and_s r0,r0,r1
L_92a65c:
	bset_s r0,r0,0x1b
L_92a65e:
	mov_s r32,r0
L_92a660:
	st.ab r0,[r25,0x4]
L_92a664:
	bclr r25,r25,0xa
L_92a668:
	bl.d L_9296c8
L_92a66c:
	mov_s r0,0x1
L_92a66e:
	lr r0,[0xa]
L_92a672:
	bic r13,r13,-0x3
L_92a676:
	or_s r13,r13,r0
L_92a678:
	flag r13
L_92a67c:
	b L_92028c
