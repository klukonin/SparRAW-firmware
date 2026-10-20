/* rs_start @ 0x9300ec, 248 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rs_start cid=%d next_tx_mcs:%u
 * Зовут его: sta__apply_bf_result, ucode_cmd_0x12_handler_uc, ucode_cmd_0x13_handler, ucode_cmd_0x30_handler_uc
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, mac__program_qset_slots, memset0_words_uc, rate_search__apply_mcs, rs__is_sta_enabled, rs_end, sched_bitmap__next_set_bit, sched_bitmap__prev_set_bit, uc_log__emit2, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rs_start
rs_start:
	.global L_9300ec
L_9300ec:
	push_s blink
L_9300ee:
	bl L_920228
L_9300f2:
	mov_s r14,r0
L_9300f4:
	mov_s r13,r1
L_9300f6:
	breq r0,0x8,L_930100
L_9300fa:
	bl L_9300ac
L_9300fe:
	brne_s r0,0,L_930104
	.global L_930100
L_930100:
	mov_s r0,0x0
L_930102:
	b_s L_9301d6
	.global L_930104
L_930104:
	brne_s r13,0,L_930100
L_930106:
	asl_s r0,r14,0x2
L_930108:
	add1_s r0,r0,r0
L_93010a:
	add r16,r0,0x802610
L_930112:
	ld r0,[r16]
L_930116:
	brne r0,0x0,L_9301da
	.global L_93011a
L_93011a:
	bl L_92b110
L_93011e:
	mov_s r0,0x802890
L_930124:
	add2_s r0,r0,r14
L_930126:
	ld_s r1,[r0,0x70]
L_930128:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_93012a:
	st_s r1,[r0,0x70]
L_93012c:
	lr r17,[0xa]
L_930130:
	bclr r0,r17,0x1
L_930134:
	flag r0
L_930138:
	mul64 r14,0x2c
L_93013c:
	mov_s r0,r14
L_93013e:
	add r13,mlo,0x802670
L_930146:
	bl.d L_92ffec
L_93014a:
	ldb_s r1,[r13,0x1e]
L_93014c:
	mov_s r15,r0
L_93014e:
	mov_s r0,r13
L_930150:
	bl.d L_920a84
L_930154:
	mov_s r1,0x2c
L_930156:
	mov_s r0,r16
L_930158:
	bl.d L_920a84
L_93015c:
	mov_s r1,0xc
L_93015e:
	mov_s r1,0x1
L_930160:
	st r1,[r16]
L_930164:
	extb_s r0,r15
L_930166:
	stb_s r15,[r13,0x1e]
L_930168:
	stb_s r1,[r13,0x1f]
L_93016a:
	brne_s r15,0,L_930174
L_93016c:
	bl.d L_92ff78
L_930170:
	extb_s r0,r14
L_930172:
	extb_s r0,r0
	.global L_930174
L_930174:
	stb_s r0,[r13,0x1c]
L_930176:
	add r0,r13,0x24
L_93017a:
	bl.d L_920a84
L_93017e:
	mov_s r1,0x8
L_930180:
	lr r1,[0xa]
L_930184:
	and r0,r17,0x2
L_930188:
	or_s r0,r0,r1
L_93018a:
	flag r0
L_93018e:
	mov_s r1,0x1001380
L_930194:
	mov_s r0,0x20
L_930196:
	mov_s r2,r14
L_930198:
	bl.d L_92d27c
L_93019c:
	ldb_s r3,[r13,0x1c]
L_93019e:
	ldb_s r0,[r13,0x1c]
L_9301a0:
	bl.d L_9300d0
L_9301a4:
	mov_s r1,r14
L_9301a6:
	mov_s r0,0x8006ac
L_9301ac:
	ldb_s r0,[r0,r14]
L_9301ae:
	bbit0 r0,0x7,L_9301d4
L_9301b2:
	mov_s r1,0x1
L_9301b4:
	mov_s r0,0x0
L_9301b6:
	bset r0,r0,r14
L_9301ba:
	st.as r0,[gp,-0x1]
L_9301be:
	/* asl_s r14,r14,0x2 */
	.byte 0x02,0xbe
L_9301c0:
	add1_s r14,r14,r14
L_9301c2:
	add_s r14,r14,0x802610
L_9301c8:
	st_s r1,[r14,0x4]
L_9301ca:
	st_s r1,[r14,0x8]
L_9301cc:
	mov_s r0,0x0
L_9301ce:
	bl.d L_92fdb4
L_9301d2:
	st_s r0,[r14]
	.global L_9301d4
L_9301d4:
	mov_s r0,0x1
	.global L_9301d6
L_9301d6:
	b L_92028c
	.global L_9301da
L_9301da:
	mov_s r0,blink
L_9301dc:
	bl.d L_926618
L_9301e0:
	mov_s r1,0x66
L_9301e2:
	b_s L_93011a
