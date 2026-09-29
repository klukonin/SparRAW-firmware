/* mac__cmd_56_57 @ 0x9368ac, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x00_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__cmd_56_57
mac__cmd_56_57:
	.global L_9368ac
L_9368ac:
	push_s blink
L_9368ae:
	ld_s r0,[gp,-0xc]
L_9368b0:
	bmsk_s r0,r0,0x3
L_9368b2:
	or r0,r0,0x563f0020
L_9368ba:
	mov_s r32,r0
L_9368bc:
	st.ab r0,[r25,0x4]
L_9368c0:
	bclr r25,r25,0xa
L_9368c4:
	mov_s r0,0x57000002
L_9368ca:
	mov_s r32,r0
L_9368cc:
	st.ab r0,[r25,0x4]
L_9368d0:
	bclr r25,r25,0xa
L_9368d4:
	pop_s blink
L_9368d6:
	j_s [blink]
