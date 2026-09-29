/* txss_init__flow @ 0x93bc90, 352 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__on_txss_init
 * Зовёт сам: __ld_r13_to_r13_ret, bf__store_flow_status, rate_search__apply_mcs, rss_wait__get, txss__program_tx_frame, txss__rank_best_sector, txss__store_sector_ranking, txss_init__send_fdbk_wait_ack, txss_init__wait_rss
 * Глобалы (через gp): 0x8005be, 0x8005f4, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txss_init__flow
txss_init__flow:
	.global L_93bc90
L_93bc90:
	push_s blink
L_93bc92:
	push_s r13
L_93bc94:
	mov_s r13,r0
L_93bc96:
	mov_s r0,0x1
L_93bc98:
	bl.d L_9300d0
L_93bc9c:
	mov_s r1,r13
L_93bc9e:
	mov_s r0,0xbf
L_93bca0:
	asl_s r0,r0,0x10
L_93bca2:
	mov_s r32,r0
L_93bca4:
	st.ab r0,[r25,0x4]
L_93bca8:
	bclr r25,r25,0xa
L_93bcac:
	mov_s r0,0x800738
L_93bcb2:
	ld_s r0,[r0,0x10]
L_93bcb4:
	lr r0,[r0]
L_93bcb8:
	bmsk_s r0,r0,0x17
L_93bcba:
	mov_s r32,r0
L_93bcbc:
	st.ab r0,[r25,0x4]
L_93bcc0:
	bclr r25,r25,0xa
L_93bcc4:
	mov_s r0,0x20
L_93bcc6:
	st.as r0,[gp,0x33]
L_93bcca:
	mov_s r1,0x8021e0
L_93bcd0:
	ld_s r0,[r1]
L_93bcd2:
	st.as 0x80000,[gp,0x34]
L_93bcda:
	bclr_s r0,r0,0x1
L_93bcdc:
	st_s r0,[r1]
L_93bcde:
	mov_s r0,0x1
L_93bce0:
	st.as r0,[gp,-0x6]
L_93bce4:
	mov_s r1,0x802968
L_93bcea:
	ldw_s r0,[gp,0x96]
L_93bcec:
	ldw_s r1,[r1,0xc]
L_93bcee:
	breq r0,r1,L_93bd1a
L_93bcf2:
	stw.as r1,[gp,0x4b]
L_93bcf6:
	or r1,r1,0x1730000
L_93bcfe:
	mov_s r0,0x886d00
L_93bd04:
	st_s r1,[r0]
L_93bd06:
	sync
L_93bd0a:
	mov_s r0,0x38000200
L_93bd10:
	mov_s r32,r0
L_93bd12:
	st.ab r0,[r25,0x4]
L_93bd16:
	bclr r25,r25,0xa
	.global L_93bd1a
L_93bd1a:
	mov_s r0,r13
L_93bd1c:
	mov_s r1,0x5
L_93bd1e:
	mov_s r2,0x0
L_93bd20:
	mov_s r3,r2
L_93bd22:
	bl.d L_93c2f8
L_93bd26:
	mov_s r4,r2
L_93bd28:
	brne r0,0x1,L_93bd72
L_93bd2c:
	st.as 0x200000,[gp,0x34]
L_93bd34:
	bl.d L_9282a8
L_93bd38:
	mov_s r0,r13
L_93bd3a:
	mov_s r1,r0
L_93bd3c:
	bl.d L_93bb18
L_93bd40:
	mov_s r0,r13
L_93bd42:
	brne r0,0x1,L_93bd7a
L_93bd46:
	mov_s r0,0x80212c
L_93bd4c:
	ldb_s r2,[r0,0x1]
L_93bd4e:
	mov_s r1,0x802a6c
L_93bd54:
	ldb_s r0,[r0]
L_93bd56:
	stw_s r2,[r1,0x20]
L_93bd58:
	stw_s r0,[r1,0x22]
L_93bd5a:
	bl.d L_93b9c0
L_93bd5e:
	mov_s r0,r13
L_93bd60:
	ld_s r0,[gp,-0x84]
L_93bd62:
	cmp_s r0,0x1
L_93bd64:
	bl.eq L_935938
L_93bd68:
	mov_s r0,r13
L_93bd6a:
	bl.d L_93e210
L_93bd6e:
	mov_s r1,0x0
L_93bd70:
	b_s L_93bd7a
	.global L_93bd72
L_93bd72:
	mov_s r0,r13
L_93bd74:
	bl.d L_9357cc
L_93bd78:
	mov_s r1,0x1
	.global L_93bd7a
L_93bd7a:
	mov_s r0,0x0
L_93bd7c:
	st.as r0,[gp,0x33]
L_93bd80:
	st.as r0,[gp,0x34]
L_93bd84:
	ld_s r0,[gp,-0x18]
L_93bd86:
	breq_s r0,0,L_93bdda
L_93bd88:
	mov_s r1,0x802968
L_93bd8e:
	ldw_s r0,[gp,0x96]
L_93bd90:
	ldw_s r1,[r1]
L_93bd92:
	breq r0,r1,L_93bdbe
L_93bd96:
	stw.as r1,[gp,0x4b]
L_93bd9a:
	or r1,r1,0x1730000
L_93bda2:
	mov_s r0,0x886d00
L_93bda8:
	st_s r1,[r0]
L_93bdaa:
	sync
L_93bdae:
	mov_s r0,0x38000200
L_93bdb4:
	mov_s r32,r0
L_93bdb6:
	st.ab r0,[r25,0x4]
L_93bdba:
	bclr r25,r25,0xa
	.global L_93bdbe
L_93bdbe:
	nop_s
L_93bdc0:
	nop_s
L_93bdc2:
	nop_s
L_93bdc4:
	mov_s r0,0x1f000601
L_93bdca:
	mov_s r32,r0
L_93bdcc:
	st.ab r0,[r25,0x4]
L_93bdd0:
	bclr r25,r25,0xa
L_93bdd4:
	mov_s r0,0x0
L_93bdd6:
	st.as r0,[gp,-0x6]
	.global L_93bdda
L_93bdda:
	mov_s r0,0x49000001
L_93bde0:
	mov_s r32,r0
L_93bde2:
	st.ab r0,[r25,0x4]
L_93bde6:
	bclr r25,r25,0xa
L_93bdea:
	b L_9202ac
L_93bdee:
	nop_s
