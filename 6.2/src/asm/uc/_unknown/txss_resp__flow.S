/* txss_resp__flow @ 0x93bff0, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__on_txss_resp
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf__flow_exit, bf__store_flow_status, rate_search__apply_mcs, rss_wait__get, sls__send_ssw_ack, txss__rank_best_sector, txss__store_sector_ranking, txss_resp__wait_fdbk, txss_resp__wait_iss_end
 * Глобалы (через gp): 0x8005be, 0x8005f4, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txss_resp__flow
txss_resp__flow:
	.global L_93bff0
L_93bff0:
	push_s blink
L_93bff2:
	bl L_920234
L_93bff6:
	mov_s r13,r0
L_93bff8:
	mov_s r14,0x1
L_93bffa:
	mov_s r0,r14
L_93bffc:
	bl.d L_9300d0
L_93c000:
	mov_s r1,r13
L_93c002:
	st.as r14,[gp,-0x6]
L_93c006:
	mov_s r0,0x40
L_93c008:
	st.as r0,[gp,0x33]
L_93c00c:
	brne r13,0x8,L_93c028
L_93c010:
	mov_s r2,0x80216c
L_93c016:
	ldw_s r0,[r2,0x1c]
L_93c018:
	mov_s r1,0x801384
L_93c01e:
	stw_s r0,[r1,0x30]
L_93c020:
	ldw_s r0,[r2,0x1e]
L_93c022:
	stw_s r0,[r1,0x32]
L_93c024:
	ldw_s r0,[r2,0x20]
L_93c026:
	stw_s r0,[r1,0x34]
	.global L_93c028
L_93c028:
	st.as 0x200000,[gp,0x34]
L_93c030:
	bl.d L_9282a8
L_93c034:
	mov_s r0,r13
L_93c036:
	mov_s r1,r0
L_93c038:
	bl.d L_93bf1c
L_93c03c:
	mov_s r0,r13
L_93c03e:
	cmp_s r0,0x1
L_93c040:
	mov_s r0,r13
L_93c042:
	bne_s L_93c06e
L_93c044:
	bl L_93be68
L_93c048:
	brne r0,0x1,L_93c05c
L_93c04c:
	mov_s r0,r13
L_93c04e:
	bl.d L_934424
L_93c052:
	mov_s r1,0x0
L_93c054:
	mov_s r0,r13
L_93c056:
	bl.d L_9357cc
L_93c05a:
	mov_s r1,0x9
	.global L_93c05c
L_93c05c:
	ld_s r0,[gp,-0x84]
L_93c05e:
	cmp_s r0,0x1
L_93c060:
	bl.eq L_935938
L_93c064:
	mov_s r0,r13
L_93c066:
	bl.d L_93e210
L_93c06a:
	mov_s r1,0x0
L_93c06c:
	b_s L_93c074
	.global L_93c06e
L_93c06e:
	bl.d L_9357cc
L_93c072:
	mov_s r1,0xb
	.global L_93c074
L_93c074:
	bl.d L_921c50
L_93c078:
	mov_s r0,r13
L_93c07a:
	ld_s r0,[gp,-0x18]
L_93c07c:
	breq_s r0,0,L_93c0d0
L_93c07e:
	mov_s r1,0x802968
L_93c084:
	ldw_s r0,[gp,0x96]
L_93c086:
	ldw_s r1,[r1]
L_93c088:
	breq r0,r1,L_93c0b4
L_93c08c:
	stw.as r1,[gp,0x4b]
L_93c090:
	or r1,r1,0x1730000
L_93c098:
	mov_s r0,0x886d00
L_93c09e:
	st_s r1,[r0]
L_93c0a0:
	sync
L_93c0a4:
	mov_s r0,0x38000200
L_93c0aa:
	mov_s r32,r0
L_93c0ac:
	st.ab r0,[r25,0x4]
L_93c0b0:
	bclr r25,r25,0xa
	.global L_93c0b4
L_93c0b4:
	nop_s
L_93c0b6:
	nop_s
L_93c0b8:
	nop_s
L_93c0ba:
	mov_s r0,0x1f000601
L_93c0c0:
	mov_s r32,r0
L_93c0c2:
	st.ab r0,[r25,0x4]
L_93c0c6:
	bclr r25,r25,0xa
L_93c0ca:
	mov_s r0,0x0
L_93c0cc:
	st.as r0,[gp,-0x6]
	.global L_93c0d0
L_93c0d0:
	b L_9202a4
