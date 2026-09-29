/* mac_qset__reset_masks @ 0x92ea48, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x07_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_qset__reset_masks
mac_qset__reset_masks:
	.global L_92ea48
L_92ea48:
	push_s blink
L_92ea4a:
	mov r1,-0x1
L_92ea4e:
	mov_s r0,0x886d80
L_92ea54:
	st_s r1,[r0,0xc]
L_92ea56:
	mov lp_count,0x6
L_92ea5a:
	mov_s r1,0x0
L_92ea5c:
	lp L_92ea6e
L_92ea60:
	mov_s r2,0x886d90
L_92ea66:
	mov_s r0,0x0
L_92ea68:
	add2_s r2,r2,r1
L_92ea6a:
	st_s r0,[r2]
L_92ea6c:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_92ea6e
L_92ea6e:
	mov_s r0,0x10f000f0
L_92ea74:
	mov_s r32,r0
L_92ea76:
	st.ab r0,[r25,0x4]
L_92ea7a:
	bclr r25,r25,0xa
L_92ea7e:
	mov_s r0,0x70
L_92ea80:
	st.as r0,[gp,-0x1f]
L_92ea84:
	ld_s r0,[gp,-0x44]
L_92ea86:
	and r0,r0,0xfffff0ff
L_92ea8e:
	st.as r0,[gp,-0x11]
L_92ea92:
	or r0,r0,0x1d000000
L_92ea9a:
	mov_s r32,r0
L_92ea9c:
	st.ab r0,[r25,0x4]
L_92eaa0:
	bclr r25,r25,0xa
L_92eaa4:
	nop_s
L_92eaa6:
	nop_s
L_92eaa8:
	nop_s
L_92eaaa:
	mov_s r0,0x1a000002
L_92eab0:
	mov_s r32,r0
L_92eab2:
	st.ab r0,[r25,0x4]
L_92eab6:
	bclr r25,r25,0xa
L_92eaba:
	pop_s blink
L_92eabc:
	j_s [blink]
L_92eabe:
	nop_s
