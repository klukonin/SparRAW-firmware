/* tx_queue__config_by_mode @ 0x8f2074, 648 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_queue.c
 * Зовут его: rf_chain_dist_config, tx_macq__config_queue
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_w_s0_w13, bf_w_s0_w3, bf_w_s14_w3, bf_w_s17_w4, bf_w_s20_w10, bf_w_s6_w14, fw_sysassert_fatal, get_g_8001e8, get_g_8001ea, get_g_800220
 */
	.section .text.tx_queue__config_by_mode,"ax",@progbits
	.global tx_queue__config_by_mode
tx_queue__config_by_mode:
	.global L_8f2074
L_8f2074:
	push_s blink
L_8f2076:
	bl L_8c02c0
L_8f207a:
	mov_s r14,r0
L_8f207c:
	mov_s r13,r1
L_8f207e:
	bl.d L_8c1a78
L_8f2082:
	mov_s r1,0x10
L_8f2084:
	/* sub_s r13,r13,0x4 */
	.byte 0x64,0xbd
L_8f2086:
	cmp_s r13,0x6
L_8f2088:
	bhi L_8f22ec
L_8f208c:
	ldw.x.as r13,[0x802280,r13]
L_8f2094:
	add r0,pcl,0x8
L_8f2098:
	add1_s r0,r0,r13
L_8f209a:
	j_s [r0]
L_8f209c:
	mov_s r13,0x0
L_8f209e:
	mov_s r0,r14
L_8f20a0:
	mov_s r1,r13
L_8f20a2:
	bl L_8e83fc
L_8f20a6:
	bl L_8e833c
L_8f20aa:
	mov_s r1,0x28
L_8f20ac:
	bset_s r1,r1,0xd
L_8f20ae:
	bl L_8e851c
L_8f20b2:
	ld_s r0,[r14]
L_8f20b4:
	bic r0,r0,0x38
L_8f20b8:
	st_s r0,[r14]
L_8f20ba:
	ld_s r0,[r14,0x4]
L_8f20bc:
	bclr_s r0,r0,0xd
L_8f20be:
	bl.d L_8cabd0
L_8f20c2:
	st_s r0,[r14,0x4]
L_8f20c4:
	bmsk r1,r0,0xc
L_8f20c8:
	add_s r0,r14,0x4
L_8f20ca:
	bl L_8e8324
	.global L_8f20ce
L_8f20ce:
	add_s r0,r14,0x4
L_8f20d0:
	mov_s r1,0x5
L_8f20d2:
	bl.d L_8e83a8
L_8f20d6:
	stw_s r13,[r14,0xe]
L_8f20d8:
	b L_8f22f8
L_8f20dc:
	mov_s r0,r14
L_8f20de:
	mov_s r1,0x1
L_8f20e0:
	bl L_8e83fc
L_8f20e4:
	mov_s r1,0x7
L_8f20e6:
	bl L_8e833c
L_8f20ea:
	mov_s r1,0x28
L_8f20ec:
	bset_s r1,r1,0xd
L_8f20ee:
	bl L_8e851c
L_8f20f2:
	ld_s r0,[r14]
L_8f20f4:
	bic r0,r0,0x38
L_8f20f8:
	bset_s r0,r0,0x4
L_8f20fa:
	b_s L_8f2116
L_8f20fc:
	mov_s r0,r14
L_8f20fe:
	mov_s r1,0x0
L_8f2100:
	bl L_8e83fc
L_8f2104:
	bl L_8e833c
L_8f2108:
	mov_s r1,0x0
L_8f210a:
	bset_s r1,r1,0xc
L_8f210c:
	bl L_8e851c
L_8f2110:
	ld_s r0,[r14]
L_8f2112:
	bic r0,r0,0x38
	.global L_8f2116
L_8f2116:
	st_s r0,[r14]
L_8f2118:
	ld_s r0,[r14,0x4]
L_8f211a:
	bclr_s r0,r0,0xd
L_8f211c:
	bl.d L_8cabd0
L_8f2120:
	st_s r0,[r14,0x4]
L_8f2122:
	bmsk r1,r0,0xc
L_8f2126:
	add_s r0,r14,0x4
L_8f2128:
	bl.d L_8e8324
L_8f212c:
	mov_s r13,0x0
L_8f212e:
	b_s L_8f20ce
L_8f2130:
	bl L_8ca0c4
L_8f2134:
	cmp_s r0,0x0
L_8f2136:
	beq_s L_8f2248
L_8f2138:
	bl L_8ca0cc
L_8f213c:
	bmsk r1,r0,0x9
L_8f2140:
	mov_s r0,r14
L_8f2142:
	bl L_8e83fc
L_8f2146:
	bl L_8ca0d8
L_8f214a:
	bmsk r1,r0,0xd
L_8f214e:
	mov_s r0,r14
L_8f2150:
	bl L_8e851c
L_8f2154:
	ld_s r0,[r14]
L_8f2156:
	mov_s r15,0xffff0000
L_8f215c:
	bset_s r0,r0,0x4
L_8f215e:
	bl.d L_8ca0d0
L_8f2162:
	st_s r0,[r14]
L_8f2164:
	bmsk r1,r0,0x2
L_8f2168:
	mov_s r0,r14
L_8f216a:
	bl L_8e833c
L_8f216e:
	bl L_8ca0c8
L_8f2172:
	bmsk_s r0,r0,0x0
L_8f2174:
	ld_s r1,[r14]
L_8f2176:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_8f2178:
	bclr_s r1,r1,0x3
L_8f217a:
	or_s r0,r0,r1
L_8f217c:
	bl.d L_8ca0f8
L_8f2180:
	st_s r0,[r14]
L_8f2182:
	ld_s r1,[r14]
L_8f2184:
	bclr_s r1,r1,0x1e
L_8f2186:
	breq_s r0,0,L_8f21e8
L_8f2188:
	bset_s r1,r1,0x1e
L_8f218a:
	bl.d L_8ca0e4
L_8f218e:
	st_s r1,[r14]
L_8f2190:
	tst_s r0,r15
L_8f2192:
	bne_s L_8f21c0
	.global L_8f2194
L_8f2194:
	mov_s r13,0x886c00
L_8f219a:
	ld_s r0,[r13,0x70]
L_8f219c:
	bl.d L_8ca0e4
L_8f21a0:
	and_s r15,r15,r0
L_8f21a2:
	or_s r0,r0,r15
L_8f21a4:
	st_s r0,[r13,0x70]
L_8f21a6:
	bl.d L_8ca10c
L_8f21aa:
	mov r15,-0x100
L_8f21ae:
	tst_s r0,r15
L_8f21b0:
	bne_s L_8f21d4
	.global L_8f21b2
L_8f21b2:
	ld_s r0,[r13,0x74]
L_8f21b4:
	bl.d L_8ca10c
L_8f21b8:
	and_s r15,r15,r0
L_8f21ba:
	or_s r0,r0,r15
L_8f21bc:
	st_s r0,[r13,0x74]
L_8f21be:
	b_s L_8f2200
	.global L_8f21c0
L_8f21c0:
	mov_s r0,blink
L_8f21c2:
	mov_s r2,0x10100b0
L_8f21c8:
	mov_s r1,0xac
L_8f21ca:
	bl.d L_8c82c0
L_8f21ce:
	mov r3,0x199
L_8f21d2:
	b_s L_8f2194
	.global L_8f21d4
L_8f21d4:
	mov_s r0,blink
L_8f21d6:
	mov_s r2,0x10100b0
L_8f21dc:
	mov_s r1,0xac
L_8f21de:
	bl.d L_8c82c0
L_8f21e2:
	mov r3,0x19a
L_8f21e6:
	b_s L_8f21b2
	.global L_8f21e8
L_8f21e8:
	st_s r1,[r14]
L_8f21ea:
	mov_s r1,0x886c00
L_8f21f0:
	ld_s r0,[r1,0x70]
L_8f21f2:
	and_s r0,r0,r15
L_8f21f4:
	bset_s r0,r0,0x0
L_8f21f6:
	st_s r0,[r1,0x70]
L_8f21f8:
	ld_s r0,[r1,0x74]
L_8f21fa:
	bic r0,r0,0xff
L_8f21fe:
	st_s r0,[r1,0x74]
	.global L_8f2200
L_8f2200:
	ld_s r0,[r14]
L_8f2202:
	bset_s r0,r0,0x5
L_8f2204:
	bl.d L_8ca0e0
L_8f2208:
	st_s r0,[r14]
L_8f220a:
	ld_s r1,[r14,0x4]
L_8f220c:
	cmp_s r0,0x0
L_8f220e:
	bclr_s r1,r1,0xd
L_8f2210:
	bset.ne r1,r1,0xd
L_8f2214:
	bl.d L_8ca120
L_8f2218:
	st_s r1,[r14,0x4]
L_8f221a:
	bmsk r1,r0,0xc
L_8f221e:
	add_s r0,r14,0x4
L_8f2220:
	bl L_8e8324
L_8f2224:
	bl L_8ca0dc
L_8f2228:
	bmsk r1,r0,0x3
L_8f222c:
	add_s r0,r14,0x4
L_8f222e:
	bl L_8e83f0
L_8f2232:
	bl L_8ca124
L_8f2236:
	bl.d L_8ca0d4
L_8f223a:
	stw_s r0,[r14,0xe]
L_8f223c:
	bmsk r1,r0,0x2
L_8f2240:
	add_s r0,r14,0x4
L_8f2242:
	bl L_8e83a8
L_8f2246:
	b_s L_8f22f8
	.global L_8f2248
L_8f2248:
	mov_s r13,0x0
L_8f224a:
	mov_s r0,r14
L_8f224c:
	mov_s r1,r13
L_8f224e:
	bl L_8e83fc
L_8f2252:
	bl L_8ca0d8
L_8f2256:
	bmsk r1,r0,0xd
L_8f225a:
	mov_s r0,r14
L_8f225c:
	bl L_8e851c
L_8f2260:
	ld_s r0,[r14]
L_8f2262:
	mov_s r1,r13
L_8f2264:
	bclr_s r0,r0,0x4
L_8f2266:
	st_s r0,[r14]
L_8f2268:
	mov_s r0,r14
L_8f226a:
	bl L_8e833c
L_8f226e:
	ld_s r0,[r14]
L_8f2270:
	bclr_s r0,r0,0x1e
L_8f2272:
	bl.d L_8ca0c8
L_8f2276:
	st_s r0,[r14]
L_8f2278:
	bmsk_s r0,r0,0x0
L_8f227a:
	ld_s r1,[r14]
L_8f227c:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_8f227e:
	bic r1,r1,0x28
L_8f2282:
	bclr_s r0,r0,0x5
L_8f2284:
	or_s r0,r0,r1
L_8f2286:
	bset_s r0,r0,0x5
L_8f2288:
	st_s r0,[r14]
L_8f228a:
	ld_s r0,[r14,0x4]
L_8f228c:
	mov_s r1,0x1fff
L_8f2292:
	bclr_s r0,r0,0xd
L_8f2294:
	st_s r0,[r14,0x4]
L_8f2296:
	add_s r0,r14,0x4
L_8f2298:
	bl L_8e8324
L_8f229c:
	stw_s r13,[r14,0xe]
L_8f229e:
	b_s L_8f22f8
L_8f22a0:
	mov_s r0,r14
L_8f22a2:
	mov r1,0x29a
L_8f22a6:
	bl L_8e83fc
L_8f22aa:
	mov r1,0x219
L_8f22ae:
	bl L_8e851c
L_8f22b2:
	ld_s r0,[r14]
L_8f22b4:
	mov_s r1,0x4
L_8f22b6:
	bset_s r0,r0,0x4
L_8f22b8:
	st_s r0,[r14]
L_8f22ba:
	mov_s r0,r14
L_8f22bc:
	bl L_8e833c
L_8f22c0:
	ld_s r0,[r14]
L_8f22c2:
	mov_s r1,0x1cc2
L_8f22c8:
	bic r0,r0,0x28
L_8f22cc:
	bset_s r0,r0,0x5
L_8f22ce:
	st_s r0,[r14]
L_8f22d0:
	ld_s r0,[r14,0x4]
L_8f22d2:
	bclr_s r0,r0,0xd
L_8f22d4:
	st_s r0,[r14,0x4]
L_8f22d6:
	add_s r0,r14,0x4
L_8f22d8:
	bl L_8e8324
L_8f22dc:
	mov_s r1,0x7
L_8f22de:
	bl L_8e83a8
L_8f22e2:
	stw 0xaf23,[r14, 0xe]
L_8f22ea:
	b_s L_8f22f8
	.global L_8f22ec
L_8f22ec:
	add_s r0,r14,0x4
L_8f22ee:
	mov_s r1,0x1fff
L_8f22f4:
	bl L_8e8324
	.global L_8f22f8
L_8f22f8:
	b L_8c032c
