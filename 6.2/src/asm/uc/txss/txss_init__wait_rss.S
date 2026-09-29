/* txss_init__wait_rss @ 0x93bb18, 376 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss_init__flow
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf__store_flow_status, gp_timer__arm, gp_timer__stop, mac_evt__enable_bit_sync_b, mac_mode__switch_core_and_rf, rx_flow__run, txss__rank_best_sector, uc_sysassert, uc_wait_event1_or_event4
 * Глобалы (через gp): 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txss_init__wait_rss
txss_init__wait_rss:
	.global L_93bb18
L_93bb18:
	push_s blink
L_93bb1a:
	bl L_920230
L_93bb1e:
	mov_s r14,r0
L_93bb20:
	mov_s r15,r1
L_93bb22:
	mov_s r13,0x0
L_93bb24:
	mov_s r0,0x20d2200
L_93bb2a:
	mov_s r32,r0
L_93bb2c:
	st.ab r0,[r25,0x4]
L_93bb30:
	bclr r25,r25,0xa
L_93bb34:
	mov_s r0,0x49000001
L_93bb3a:
	mov_s r32,r0
L_93bb3c:
	st.ab r0,[r25,0x4]
L_93bb40:
	bclr r25,r25,0xa
L_93bb44:
	bl.d L_936544
L_93bb48:
	mov_s r0,0x5
L_93bb4a:
	mov_s r0,0x0
L_93bb4c:
	bl.d L_93512c
L_93bb50:
	mov_s r1,r15
L_93bb52:
	mov_s r1,0x1489b5
L_93bb58:
	bl.d L_93512c
L_93bb5c:
	mov_s r0,0x1
L_93bb5e:
	b_s L_93bb6c
	.global L_93bb60
L_93bb60:
	bl.d L_935938
L_93bb64:
	mov_s r13,0x1
L_93bb66:
	bl.d L_925998
L_93bb6a:
	mov_s r0,0x0
	.global L_93bb6c
L_93bb6c:
	mov_s r0,0x0
L_93bb6e:
	bset_s r0,r0,0x13
L_93bb70:
	mov_s r1,0xc1
L_93bb72:
	bl.d L_9367e4
L_93bb76:
	mov_s r2,0x0
L_93bb78:
	mov_s r0,r54
L_93bb7a:
	bbit1 r0,0x0,L_93bbc8
L_93bb7e:
	mov_s r0,r42
L_93bb80:
	bbit0 r0,0x13,L_93bbb0
L_93bb84:
	bl L_930dd4
L_93bb88:
	mov_s r0,0x8021e0
L_93bb8e:
	ld_s r0,[r0]
L_93bb90:
	bbit1 r0,0x2,L_93bb9e
L_93bb94:
	bbit0 r0,0x4,L_93bbb6
L_93bb98:
	mov_s r0,r14
L_93bb9a:
	mov_s r1,0x8
L_93bb9c:
	b_s L_93bbf2
	.global L_93bb9e
L_93bb9e:
	brne_s r13,0,L_93bba6
	.global L_93bba0
L_93bba0:
	mov_s r0,r14
L_93bba2:
	mov_s r1,0x7
L_93bba4:
	b_s L_93bbf2
	.global L_93bba6
L_93bba6:
	mov_s r0,blink
L_93bba8:
	bl.d L_926618
L_93bbac:
	mov_s r1,0x89
L_93bbae:
	b_s L_93bba0
	.global L_93bbb0
L_93bbb0:
	mov_s r0,r54
L_93bbb2:
	bbit1 r0,0x6,L_93bbde
	.global L_93bbb6
L_93bbb6:
	mov_s r1,r54
L_93bbb8:
	mov_s r0,0x8021e0
L_93bbbe:
	bbit0 r1,0x7,L_93bbc8
L_93bbc2:
	ld_s r0,[r0]
L_93bbc4:
	bbit0 r0,0x1,L_93bbfa
	.global L_93bbc8
L_93bbc8:
	mov_s r0,r54
L_93bbca:
	mov_s r1,0x8021e0
L_93bbd0:
	bbit1 r0,0x0,L_93bc06
L_93bbd4:
	ld_s r0,[r1]
L_93bbd6:
	bbit1 r0,0x1,L_93bc06
L_93bbda:
	mov_s r0,0x0
L_93bbdc:
	b_s L_93bc08
	.global L_93bbde
L_93bbde:
	brne_s r13,0,L_93bbe6
	.global L_93bbe0
L_93bbe0:
	mov_s r0,r14
L_93bbe2:
	mov_s r1,0x2
L_93bbe4:
	b_s L_93bbf2
	.global L_93bbe6
L_93bbe6:
	mov_s r0,blink
L_93bbe8:
	bl.d L_926618
L_93bbec:
	mov r1,0x102
L_93bbf0:
	b_s L_93bbe0
	.global L_93bbf2
L_93bbf2:
	bl L_9357cc
L_93bbf6:
	mov_s r0,0x0
L_93bbf8:
	b_s L_93bc84
	.global L_93bbfa
L_93bbfa:
	bl.d L_925998
L_93bbfe:
	mov_s r0,0x1
L_93bc00:
	mov_s r0,r14
L_93bc02:
	mov_s r1,0x3
L_93bc04:
	b_s L_93bbf2
	.global L_93bc06
L_93bc06:
	mov_s r0,0x1
	.global L_93bc08
L_93bc08:
	extb.f 0x0,r0
L_93bc0c:
	ld_s r0,[r1]
L_93bc0e:
	bne_s L_93bc1c
L_93bc10:
	bbit0 r0,0x0,L_93bc88
L_93bc14:
	bclr_s r0,r0,0x0
L_93bc16:
	st_s r0,[r1]
L_93bc18:
	mov_s r0,0x1
L_93bc1a:
	b_s L_93bc8a
	.global L_93bc1c
L_93bc1c:
	bbit1 r0,0x1,L_93bc34
L_93bc20:
	mov_s r1,0x80110c
L_93bc26:
	asl_s r0,r14,0x4
L_93bc28:
	add2_s r0,r0,r0
L_93bc2a:
	bl.d L_92e0e4
L_93bc2e:
	ld_s r0,[r1,r0]
L_93bc30:
	mov_s r0,0x0
L_93bc32:
	b_s L_93bc36
	.global L_93bc34
L_93bc34:
	mov_s r0,0x1
	.global L_93bc36
L_93bc36:
	st.as r0,[gp,-0x21]
L_93bc3a:
	mov_s r0,0x3e
L_93bc3c:
	asl_s r0,r0,0x18
L_93bc3e:
	mov_s r32,r0
L_93bc40:
	st.ab r0,[r25,0x4]
L_93bc44:
	bclr r25,r25,0xa
L_93bc48:
	mov_s r0,0x37000020
L_93bc4e:
	mov_s r32,r0
L_93bc50:
	st.ab r0,[r25,0x4]
L_93bc54:
	bclr r25,r25,0xa
L_93bc58:
	mov_s r1,0x8022c8
L_93bc5e:
	ld_s r0,[r1,0xc]
L_93bc60:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93bc62:
	st_s r0,[r1,0xc]
L_93bc64:
	ld_s r0,[gp,0x178]
L_93bc66:
	mov_s r1,0x802940
L_93bc6c:
	bclr_s r0,r0,0x18
L_93bc6e:
	ld_s r1,[r1]
L_93bc70:
	bclr_s r0,r0,0x19
L_93bc72:
	asl_s r1,r1,0x18
L_93bc74:
	or_s r0,r0,r1
L_93bc76:
	st.as r0,[gp,0x5e]
L_93bc7a:
	mov_s r1,0x889480
L_93bc80:
	st_s r0,[r1,0x8]
L_93bc82:
	mov_s r0,0x1
	.global L_93bc84
L_93bc84:
	b L_92029c
	.global L_93bc88
L_93bc88:
	mov_s r0,0x0
	.global L_93bc8a
L_93bc8a:
	cmp_s r0,0x1
L_93bc8c:
	bne_s L_93bb6c
L_93bc8e:
	b_s L_93bb60
