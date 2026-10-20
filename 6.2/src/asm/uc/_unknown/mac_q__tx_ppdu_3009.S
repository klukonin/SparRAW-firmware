/* mac_q__tx_ppdu_3009 @ 0x921760, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txop_initiator_open_txop_flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_q__tx_ppdu_3009
mac_q__tx_ppdu_3009:
	.global L_921760
L_921760:
	push_s blink
L_921762:
	bl L_920234
L_921766:
	ld_s r13,[r0,0x4]
L_921768:
	ld_s r14,[r0]
L_92176a:
	mov_s r0,0x886500
L_921770:
	ld_s r0,[r0,0x6c]
L_921772:
	bmsk.f 0x0,r0,0x3
L_921776:
	mov.ne r0,blink
L_92177a:
	bl.ne.d L_926618
L_92177e:
	mov.ne r1,0x3
L_921782:
	mov_s r0,0x1c000006
L_921788:
	mov_s r32,r0
L_92178a:
	st.ab r0,[r25,0x4]
L_92178e:
	bclr r25,r25,0xa
L_921792:
	asl_s r0,r13,0x4
L_921794:
	or r0,r0,0x46003009
L_92179c:
	mov_s r32,r0
L_92179e:
	st.ab r0,[r25,0x4]
L_9217a2:
	bclr r25,r25,0xa
L_9217a6:
	mov_s r1,0x8022c8
L_9217ac:
	ld_s r0,[r1,0x14]
L_9217ae:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9217b0:
	st_s r0,[r1,0x14]
	.global L_9217b2
L_9217b2:
	mov_s r0,r53
L_9217b4:
	bbit0 r0,0x2,L_9217b2
L_9217b8:
	ld_s r0,[gp,-0x44]
L_9217ba:
	and r0,r0,0xfff0ffff
L_9217c2:
	bset r1,r0,0x10
L_9217c6:
	or r0,r0,0x1d010000
L_9217ce:
	st.as r1,[gp,-0x11]
L_9217d2:
	mov_s r32,r0
L_9217d4:
	st.ab r0,[r25,0x4]
L_9217d8:
	bclr r25,r25,0xa
L_9217dc:
	nop_s
L_9217de:
	nop_s
L_9217e0:
	nop_s
	.global L_9217e2
L_9217e2:
	mov_s r0,r47
L_9217e4:
	bbit1 r0,0x0,L_9217e2
L_9217e8:
	asl_s r14,r14,0x8
L_9217ea:
	bset_s r14,r14,0x1a
L_9217ec:
	bset_s r14,r14,0x1e
L_9217ee:
	or_s r13,r13,r14
L_9217f0:
	bset_s r13,r13,0x13
L_9217f2:
	bset_s r13,r13,0x15
L_9217f4:
	mov_s r32,r13
L_9217f6:
	st.ab r13,[r25,0x4]
L_9217fa:
	bclr r25,r25,0xa
L_9217fe:
	mov_s r0,0x45000001
L_921804:
	mov_s r32,r0
L_921806:
	st.ab r0,[r25,0x4]
L_92180a:
	bclr r25,r25,0xa
L_92180e:
	mov_s r0,0x460001f1
L_921814:
	mov_s r32,r0
L_921816:
	st.ab r0,[r25,0x4]
L_92181a:
	bclr r25,r25,0xa
L_92181e:
	b L_9202a4
L_921822:
	nop_s
