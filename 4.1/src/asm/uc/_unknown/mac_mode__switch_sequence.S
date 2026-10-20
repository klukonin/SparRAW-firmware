/* mac_mode__switch_sequence @ 0x925a50, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_task__dispatch
 * Зовёт сам: __ld_r13_ret_uc, brp_step_b, mac__switch_core_and_setup_dma, uc_timers__start_defaults, uc_timers__start_defaults_b
 * Глобалы (через gp): 0x8005d6
 */
	.section .text.mac_mode__switch_sequence,"ax",@progbits
	.global mac_mode__switch_sequence
mac_mode__switch_sequence:
	.global L_925a50
L_925a50:
	push_s blink
L_925a52:
	push_s r13
L_925a54:
	mov_s r13,r0
L_925a56:
	or r0,r0,0xaa00
L_925a5e:
	mov_s r32,r0
L_925a60:
	st.ab r0,[r25,0x4]
L_925a64:
	bclr r25,r25,0xa
L_925a68:
	mov_s r0,0x8006a4
L_925a6e:
	ld_s r0,[r0,0x10]
L_925a70:
	lr r0,[r0]
L_925a74:
	bmsk_s r0,r0,0x17
L_925a76:
	mov_s r32,r0
L_925a78:
	st.ab r0,[r25,0x4]
L_925a7c:
	bclr r25,r25,0xa
L_925a80:
	breq r13,0x0,L_925ae2
L_925a84:
	ldb_s r0,[gp,-0xf1]
L_925a86:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_925a88:
	bl.d L_936dac
L_925a8c:
	stb r0,[gp, -0xf1]
L_925a90:
	bl.d L_936d64
L_925a94:
	mov_s r0,0x1
L_925a96:
	mov_s r0,0x0
L_925a98:
	bset_s r0,r0,0x18
L_925a9a:
	mov_s r32,r0
L_925a9c:
	st.ab r0,[r25,0x4]
L_925aa0:
	bclr r25,r25,0xa
L_925aa4:
	mov_s r0,0x20c0010
L_925aaa:
	mov_s r32,r0
L_925aac:
	st.ab r0,[r25,0x4]
L_925ab0:
	bclr r25,r25,0xa
L_925ab4:
	mov_s r1,0x2
L_925ab6:
	mov_s r0,0x886d80
L_925abc:
	st_s r1,[r0,0x50]
L_925abe:
	sync
L_925ac2:
	mov_s r1,0x2
L_925ac4:
	mov_s r0,0x886d80
L_925aca:
	st_s r1,[r0,0x64]
L_925acc:
	sync
L_925ad0:
	mov_s r1,0x4
L_925ad2:
	mov_s r0,0x886d80
L_925ad8:
	st_s r1,[r0,0x64]
L_925ada:
	sync
L_925ade:
	mov_s r0,0x1
L_925ae0:
	b_s L_925b2a
	.global L_925ae2
L_925ae2:
	ldb_s r0,[gp,-0xf2]
L_925ae4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_925ae6:
	bl.d L_936d88
L_925aea:
	stb r0,[gp, -0xf2]
L_925aee:
	ldw_s r0,[gp,0xae]
L_925af0:
	breq_s r0,0,L_925b02
L_925af2:
	mov_s r0,0x1ffffff
L_925af8:
	mov_s r32,r0
L_925afa:
	st.ab r0,[r25,0x4]
L_925afe:
	bclr r25,r25,0xa
	.global L_925b02
L_925b02:
	bl.d L_936d64
L_925b06:
	mov_s r0,0x0
L_925b08:
	bl L_923870
L_925b0c:
	mov_s r1,0x4
L_925b0e:
	mov_s r0,0x886d80
L_925b14:
	st_s r1,[r0,0x50]
L_925b16:
	sync
L_925b1a:
	mov_s r1,0x4
L_925b1c:
	mov_s r0,0x886d80
L_925b22:
	st_s r1,[r0,0x64]
L_925b24:
	sync
L_925b28:
	mov_s r0,0x0
	.global L_925b2a
L_925b2a:
	b.d L_92028c
L_925b2e:
	stb r0,[gp, -0xe5]
L_925b32:
	nop_s
