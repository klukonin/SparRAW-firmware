/* mac__set_chain_mask_924f00 @ 0x926808, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x08_handler
 * Зовёт сам: mac__rf_switch_cmd1f
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__set_chain_mask_924f00
mac__set_chain_mask_924f00:
	.global L_926808
L_926808:
	st.as 0x924f00,[gp,-0x35]
L_926810:
	mov_s r0,0x80146c
L_926816:
	ld_s r0,[r0,0x8]
L_926818:
	and r0,r0,0x924f00
L_926820:
	bset_s r0,r0,0x1b
L_926822:
	mov_s r32,r0
L_926824:
	st.ab r0,[r25,0x4]
L_926828:
	bclr r25,r25,0xa
L_92682c:
	mov_s r0,0x81
L_92682e:
	asl_s r0,r0,0x12
L_926830:
	mov_s r32,r0
L_926832:
	st.ab r0,[r25,0x4]
L_926836:
	bclr r25,r25,0xa
L_92683a:
	b.d L_92c5e4
L_92683e:
	mov_s r0,0x1
