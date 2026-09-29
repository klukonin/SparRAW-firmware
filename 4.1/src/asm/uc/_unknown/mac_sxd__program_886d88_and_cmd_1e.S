/* mac_sxd__program_886d88_and_cmd_1e @ 0x93160c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 */
	.section .text.mac_sxd__program_886d88_and_cmd_1e,"ax",@progbits
	.global mac_sxd__program_886d88_and_cmd_1e
mac_sxd__program_886d88_and_cmd_1e:
	.global L_93160c
L_93160c:
	push_s blink
L_93160e:
	mov_s r0,0x886d80
L_931614:
	st 0xc0a0f1e,[r0, 0x8]
L_93161c:
	mov_s r0,0x1e010004
L_931622:
	mov_s r32,r0
L_931624:
	st.ab r0,[r25,0x4]
L_931628:
	bclr r25,r25,0xa
L_93162c:
	mov_s r0,0x1e010001
L_931632:
	mov_s r32,r0
L_931634:
	st.ab r0,[r25,0x4]
L_931638:
	bclr r25,r25,0xa
L_93163c:
	pop_s blink
L_93163e:
	j_s [blink]
