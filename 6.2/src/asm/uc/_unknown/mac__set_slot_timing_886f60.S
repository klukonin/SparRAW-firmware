/* mac__set_slot_timing_886f60 @ 0x93b40c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__set_slot_timing_886f60
mac__set_slot_timing_886f60:
	.global L_93b40c
L_93b40c:
	push_s blink
L_93b40e:
	mov_s r0,0x4a000018
L_93b414:
	mov_s r32,r0
L_93b416:
	st.ab r0,[r25,0x4]
L_93b41a:
	bclr r25,r25,0xa
L_93b41e:
	mov_s r0,0x886f00
L_93b424:
	st 0x3780378,[r0, 0x60]
L_93b42c:
	pop_s blink
L_93b42e:
	j_s [blink]
