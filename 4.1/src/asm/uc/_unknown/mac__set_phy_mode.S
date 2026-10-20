/* mac__set_phy_mode @ 0x9319bc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x00_handler
 */
	.section .text.mac__set_phy_mode,"ax",@progbits
	.global mac__set_phy_mode
mac__set_phy_mode:
	.global L_9319bc
L_9319bc:
	push_s blink
L_9319be:
	ld_s r0,[gp,-0x10]
L_9319c0:
	bmsk_s r0,r0,0x3
L_9319c2:
	or r0,r0,0x563f0020
L_9319ca:
	mov_s r32,r0
L_9319cc:
	st.ab r0,[r25,0x4]
L_9319d0:
	bclr r25,r25,0xa
L_9319d4:
	mov_s r0,0x57000002
L_9319da:
	mov_s r32,r0
L_9319dc:
	st.ab r0,[r25,0x4]
L_9319e0:
	bclr r25,r25,0xa
L_9319e4:
	pop_s blink
L_9319e6:
	j_s [blink]
