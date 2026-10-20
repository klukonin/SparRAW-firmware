/* mac__set_slot_mask_924000 @ 0x9267d4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1__enter_fixed_sched
 * Зовёт сам: mac__rf_switch_cmd1f
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__set_slot_mask_924000
mac__set_slot_mask_924000:
	.global L_9267d4
L_9267d4:
	push_s blink
L_9267d6:
	st.as 0x924000,[gp,-0x35]
L_9267de:
	mov_s r0,0x8924000
L_9267e4:
	mov_s r32,r0
L_9267e6:
	st.ab r0,[r25,0x4]
L_9267ea:
	bclr r25,r25,0xa
L_9267ee:
	bl.d L_92c5e4
L_9267f2:
	mov_s r0,0x1
L_9267f4:
	mov_s r0,0x81
L_9267f6:
	asl_s r0,r0,0x12
L_9267f8:
	mov_s r32,r0
L_9267fa:
	st.ab r0,[r25,0x4]
L_9267fe:
	bclr r25,r25,0xa
L_926802:
	pop_s blink
L_926804:
	j_s [blink]
L_926806:
	nop_s
