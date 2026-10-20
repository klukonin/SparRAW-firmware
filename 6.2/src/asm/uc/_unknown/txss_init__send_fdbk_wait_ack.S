/* txss_init__send_fdbk_wait_ack @ 0x93b9c0, 344 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss_init__flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf__store_flow_status, gp_timer__arm, mac_evt__enable_bit_sync, mac_evt__enable_bit_sync_b, mac_mode__switch_core_and_rf, rx_flow__run, sls__clear_rx_state, txss_init__send_ssw_fdbk, uc_sysassert, uc_wait_event1_or_event4
 * Глобалы (через gp): 0x8005be, 0x8005f4, 0x8005f8, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txss_init__send_fdbk_wait_ack
txss_init__send_fdbk_wait_ack:
	.global L_93b9c0
L_93b9c0:
	push_s blink
L_93b9c2:
	bl.d L_920234
L_93b9c6:
	mov_s r1,0x4
L_93b9c8:
	st.as 0x400000,[gp,0x34]
L_93b9d0:
	bl.d L_9357cc
L_93b9d4:
	mov_s r13,r0
L_93b9d6:
	mov_s r0,0x1
L_93b9d8:
	mov_s r1,r13
L_93b9da:
	bl.d L_93c0d4
L_93b9de:
	mov_s r2,0x0
L_93b9e0:
	mov_s r0,0x802968
L_93b9e6:
	ldw.as r1,[gp,0x4b]
L_93b9ea:
	ldw_s r0,[r0]
L_93b9ec:
	breq r1,r0,L_93ba18
L_93b9f0:
	stw.as r0,[gp,0x4b]
L_93b9f4:
	or r0,r0,0x1730000
L_93b9fc:
	mov_s r1,0x886d00
L_93ba02:
	st_s r0,[r1]
L_93ba04:
	sync
L_93ba08:
	mov_s r0,0x38000200
L_93ba0e:
	mov_s r32,r0
L_93ba10:
	st.ab r0,[r25,0x4]
L_93ba14:
	bclr r25,r25,0xa
	.global L_93ba18
L_93ba18:
	ld_s r0,[gp,0x178]
L_93ba1a:
	mov_s r1,0x802944
L_93ba20:
	bclr_s r0,r0,0x18
L_93ba22:
	ld_s r1,[r1]
L_93ba24:
	bclr_s r0,r0,0x19
L_93ba26:
	asl_s r1,r1,0x18
L_93ba28:
	or_s r0,r0,r1
L_93ba2a:
	st.as r0,[gp,0x5e]
L_93ba2e:
	mov_s r1,0x889480
L_93ba34:
	st_s r0,[r1,0x8]
L_93ba36:
	mov_s r0,0x0
L_93ba38:
	st.as r0,[gp,-0x6]
L_93ba3c:
	mov_s r0,0x41
L_93ba3e:
	asl_s r0,r0,0x13
L_93ba40:
	mov_s r32,r0
L_93ba42:
	st.ab r0,[r25,0x4]
L_93ba46:
	bclr r25,r25,0xa
L_93ba4a:
	bl.d L_9361bc
L_93ba4e:
	mov_s r0,0x5
L_93ba50:
	mov_s r14,0x1
L_93ba52:
	mov_s r0,r14
L_93ba54:
	mov_s r1,0x87
L_93ba56:
	bl.d L_93512c
L_93ba5a:
	bset_s r1,r1,0xd
	.global L_93ba5c
L_93ba5c:
	mov_s r0,0x0
L_93ba5e:
	bset_s r0,r0,0x13
L_93ba60:
	mov_s r1,0x80
L_93ba62:
	bl.d L_9367e4
L_93ba66:
	mov_s r2,0x0
L_93ba68:
	mov_s r0,r42
L_93ba6a:
	bbit1 r0,0x13,L_93bac4
L_93ba6e:
	mov_s r0,r54
L_93ba70:
	bbit0 r0,0x7,L_93bb0c
L_93ba74:
	brhs r14,0x3,L_93bafa
L_93ba78:
	mov_s r1,0x80110c
L_93ba7e:
	asl_s r0,r13,0x4
L_93ba80:
	add2_s r0,r0,r0
L_93ba82:
	bl.d L_92e0e4
L_93ba86:
	ld_s r0,[r1,r0]
L_93ba88:
	mov_s r0,0x1
L_93ba8a:
	mov_s r1,r13
L_93ba8c:
	bl.d L_93c0d4
L_93ba90:
	mov_s r2,r0
L_93ba92:
	bl.d L_936544
L_93ba96:
	mov_s r0,0x5
L_93ba98:
	ld_s r0,[gp,0x178]
L_93ba9a:
	mov_s r1,0x802944
L_93baa0:
	bclr_s r0,r0,0x18
L_93baa2:
	ld_s r1,[r1]
L_93baa4:
	bclr_s r0,r0,0x19
L_93baa6:
	asl_s r1,r1,0x18
L_93baa8:
	or_s r0,r0,r1
L_93baaa:
	st.as r0,[gp,0x5e]
L_93baae:
	mov_s r1,0x889480
L_93bab4:
	st_s r0,[r1,0x8]
L_93bab6:
	mov_s r0,0x1
L_93bab8:
	mov_s r1,0x87
L_93baba:
	bl.d L_93512c
L_93babe:
	bset_s r1,r1,0xd
L_93bac0:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_93bac2:
	b_s L_93ba5c
	.global L_93bac4
L_93bac4:
	bl L_930dd4
L_93bac8:
	mov_s r0,0x8021e0
L_93bace:
	ld_s r0,[r0]
L_93bad0:
	bbit1 r0,0x3,L_93bae6
L_93bad4:
	bbit1 r0,0x0,L_93baf0
L_93bad8:
	bbit0 r0,0x2,L_93ba5c
L_93badc:
	mov_s r0,r13
L_93bade:
	bl.d L_9357cc
L_93bae2:
	mov_s r1,0x7
L_93bae4:
	b_s L_93bafe
	.global L_93bae6
L_93bae6:
	mov_s r0,r13
L_93bae8:
	bl.d L_9357cc
L_93baec:
	mov_s r1,0x5
L_93baee:
	b_s L_93bafe
	.global L_93baf0
L_93baf0:
	mov_s r0,r13
L_93baf2:
	bl.d L_9357cc
L_93baf6:
	mov_s r1,0x6
L_93baf8:
	b_s L_93bafe
	.global L_93bafa
L_93bafa:
	bl L_92ed50
	.global L_93bafe
L_93bafe:
	mov_s r0,0x0
L_93bb00:
	st.as r0,[gp,0x33]
L_93bb04:
	b.d L_9202a4
L_93bb08:
	st.as r0,[gp,0x34]
	.global L_93bb0c
L_93bb0c:
	mov_s r0,blink
L_93bb0e:
	bl.d L_926618
L_93bb12:
	mov_s r1,0xd
L_93bb14:
	b_s L_93ba5c
L_93bb16:
	nop_s
