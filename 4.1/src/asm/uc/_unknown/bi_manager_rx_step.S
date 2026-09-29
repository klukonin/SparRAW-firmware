/* bi_manager_rx_step @ 0x921a48, 272 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__rx_bi_flow
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bi_manager__rx_flow_body, get_reg_88c120, rx_flow__run, sxd_hal__read_backoff_status, sxd_hal__wait_slot2_busy2, tx__pick_slot_for_peer
 * Глобалы (через gp): 0x800604, 0x800608
 */
	.section .text.bi_manager_rx_step,"ax",@progbits
	.global bi_manager_rx_step
bi_manager_rx_step:
	.global L_921a48
L_921a48:
	push_s blink
L_921a4a:
	bl L_920210
L_921a4e:
	mov_s r15,r0
L_921a50:
	bl.d L_926ce8
L_921a54:
	mov_s r14,r1
L_921a56:
	cmp_s r14,0x0
L_921a58:
	mov.ne r1,0x1ef0
L_921a60:
	mov.eq r1,0x13fb
L_921a68:
	brlo.d r0,r1,L_921ac8
L_921a6c:
	mov_s r13,0x0
L_921a6e:
	mov_s r0,r15
L_921a70:
	mov_s r13,0x0
L_921a72:
	mov_s r1,r13
L_921a74:
	bl.d L_932704
L_921a78:
	mov_s r2,r14
L_921a7a:
	brne_s r0,0,L_921a8e
L_921a7c:
	ldb_s r0,[gp,-0xf7]
L_921a7e:
	st.as 0x800,[gp,0x38]
L_921a86:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_921a88:
	stb r0,[gp, -0xf7]
L_921a8c:
	b_s L_921ac8
	.global L_921a8e
L_921a8e:
	breq_s r14,0,L_921ac6
L_921a90:
	bl.d L_931dcc
L_921a94:
	ldw_s r0,[gp,-0x24]
L_921a96:
	breq_s r0,0,L_921aac
L_921a98:
	bl L_92ce9c
L_921a9c:
	breq_s r0,0,L_921aa8
L_921a9e:
	mov_s r0,r36
L_921aa0:
	btst_s r0,0x8
L_921aa2:
	mov_s r13,0x0
L_921aa4:
	mov.ne r13,0x1
	.global L_921aa8
L_921aa8:
	extb_s r13,r13
L_921aaa:
	b_s L_921ab6
	.global L_921aac
L_921aac:
	mov_s r0,0x1
L_921aae:
	mov_s r1,r15
L_921ab0:
	bl.d L_924db8
L_921ab4:
	mov_s r2,0x1f
	.global L_921ab6
L_921ab6:
	mov_s r0,0x0
L_921ab8:
	bset_s r0,r0,0x1d
L_921aba:
	mov_s r32,r0
L_921abc:
	st.ab r0,[r25,0x4]
L_921ac0:
	bclr r25,r25,0xa
L_921ac4:
	b_s L_921ac8
	.global L_921ac6
L_921ac6:
	mov_s r13,0x1
	.global L_921ac8
L_921ac8:
	mov_s r0,0x14000100
L_921ace:
	mov_s r32,r0
L_921ad0:
	st.ab r0,[r25,0x4]
L_921ad4:
	bclr r25,r25,0xa
L_921ad8:
	ldw_s r0,[gp,0xdc]
L_921ada:
	or r0,r0,0xdc0000
L_921ae2:
	mov_s r32,r0
L_921ae4:
	st.ab r0,[r25,0x4]
L_921ae8:
	bclr r25,r25,0xa
L_921aec:
	ld_s r0,[gp,0xdc]
L_921aee:
	lsr_s r0,r0,0x10
L_921af0:
	or r0,r0,0xdc0000
L_921af8:
	mov_s r32,r0
L_921afa:
	st.ab r0,[r25,0x4]
L_921afe:
	bclr r25,r25,0xa
L_921b02:
	ldw_s r0,[gp,0xe0]
L_921b04:
	or r0,r0,0xdc0000
L_921b0c:
	mov_s r32,r0
L_921b0e:
	st.ab r0,[r25,0x4]
L_921b12:
	bclr r25,r25,0xa
L_921b16:
	ld_s r0,[gp,0xe0]
L_921b18:
	lsr_s r0,r0,0x10
L_921b1a:
	or r0,r0,0xdc0000
L_921b22:
	mov_s r32,r0
L_921b24:
	st.ab r0,[r25,0x4]
L_921b28:
	bclr r25,r25,0xa
L_921b2c:
	mov_s r0,0x0
L_921b2e:
	st.as r0,[gp,0x37]
L_921b32:
	st.as r0,[gp,0x38]
L_921b36:
	mov_s r1,0x801a18
L_921b3c:
	st_s r0,[r1,0xc]
L_921b3e:
	st_s r0,[r1,0x3c]
L_921b40:
	mov_s r0,0x81
L_921b42:
	asl_s r0,r0,0x12
L_921b44:
	mov_s r32,r0
L_921b46:
	st.ab r0,[r25,0x4]
L_921b4a:
	bclr r25,r25,0xa
L_921b4e:
	bl L_9377bc
L_921b52:
	b.d L_92027c
L_921b56:
	mov_s r0,r13
