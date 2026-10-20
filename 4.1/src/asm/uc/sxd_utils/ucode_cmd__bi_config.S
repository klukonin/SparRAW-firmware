/* ucode_cmd__bi_config @ 0x932f8c, 584 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   /home/gatis/sdk/sparrow/fwsrc4/src/ucode/inc/sxd_utils.h
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, disable_tsf_event, mac__program_tx_with_qid, memcpy_uc, tail_bi_cfg__apply, uc_sysassert
 * Глобалы (через gp): 0x800610, 0x800614
 */
	.section .text.ucode_cmd__bi_config,"ax",@progbits
	.global ucode_cmd__bi_config
ucode_cmd__bi_config:
	.global L_932f8c
L_932f8c:
	push_s blink
L_932f8e:
	bl.d L_920214
L_932f92:
	mov_s r2,0x38
L_932f94:
	sub_s sp,sp,0x34
L_932f96:
	mov_s r13,r0
L_932f98:
	mov_s r14,0x801a9c
L_932f9e:
	mov_s r0,r14
L_932fa0:
	bl.d L_920310
L_932fa4:
	add_s r1,r13,0x4
L_932fa6:
	mov_s r0,0x801438
L_932fac:
	add2 r1,r13,0x1d
L_932fb0:
	bl.d L_920310
L_932fb4:
	mov_s r2,0x20
L_932fb6:
	ldb r0,[r13, 0x7d]
L_932fba:
	st_s r0,[r14,0x54]
L_932fbc:
	mov_s r0,0x0
L_932fbe:
	st_s r0,[r14,0x5c]
L_932fc0:
	ld_s r1,[r13]
L_932fc2:
	cmp_s r1,0x0
L_932fc4:
	beq_s L_9330ac
L_932fc6:
	cmp_s r1,0x1
L_932fc8:
	beq_s L_9330b4
L_932fca:
	cmp_s r1,0x2
L_932fcc:
	bne L_933192
L_932fd0:
	bl L_9331d4
L_932fd4:
	mov_s r0,0x886500
L_932fda:
	ld_s r0,[r0,0x6c]
L_932fdc:
	bmsk.f 0x0,r0,0x3
L_932fe0:
	beq_s L_932ff4
L_932fe2:
	mov_s r0,blink
L_932fe4:
	mov_s r2,0x1002004
L_932fea:
	mov_s r1,0x3
L_932fec:
	bl.d L_925548
L_932ff0:
	mov r3,0x154
	.global L_932ff4
L_932ff4:
	mov_s r0,0x1c000006
L_932ffa:
	mov_s r32,r0
L_932ffc:
	st.ab r0,[r25,0x4]
L_933000:
	bclr r25,r25,0xa
L_933004:
	mov_s r0,0x460001e8
L_93300a:
	mov_s r32,r0
L_93300c:
	st.ab r0,[r25,0x4]
L_933010:
	bclr r25,r25,0xa
L_933014:
	mov_s r1,0x801458
L_93301a:
	ld_s r0,[r1,0x14]
L_93301c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93301e:
	st_s r0,[r1,0x14]
	.global L_933020
L_933020:
	mov_s r0,r53
L_933022:
	bbit0 r0,0x2,L_933020
L_933026:
	ld_s r0,[gp,-0x44]
L_933028:
	and r0,r0,0xfff0ffff
L_933030:
	bset r1,r0,0x10
L_933034:
	or r0,r0,0x1d010000
L_93303c:
	st.as r1,[gp,-0x11]
L_933040:
	mov_s r32,r0
L_933042:
	st.ab r0,[r25,0x4]
L_933046:
	bclr r25,r25,0xa
L_93304a:
	nop_s
L_93304c:
	nop_s
L_93304e:
	nop_s
	.global L_933050
L_933050:
	mov_s r0,r47
L_933052:
	bbit1 r0,0x0,L_933050
L_933056:
	mov_s r0,0x4428001e
L_93305c:
	mov_s r32,r0
L_93305e:
	st.ab r0,[r25,0x4]
L_933062:
	bclr r25,r25,0xa
L_933066:
	mov_s r0,0x45000001
L_93306c:
	mov_s r32,r0
L_93306e:
	st.ab r0,[r25,0x4]
L_933072:
	bclr r25,r25,0xa
L_933076:
	mov_s r0,0x460001f1
L_93307c:
	mov_s r32,r0
L_93307e:
	st.ab r0,[r25,0x4]
L_933082:
	bclr r25,r25,0xa
L_933086:
	mov_s r0,0x1e
L_933088:
	bl.d L_92a36c
L_93308c:
	st_s r0,[sp,0x4]
	.global L_93308e
L_93308e:
	mov_s r0,r43
L_933090:
	bbit0 r0,0x1f,L_93308e
L_933094:
	mov_s r0,r51
L_933096:
	bmsk r1,r0,0x3
L_93309a:
	st.as r1,[gp,0x3a]
L_93309e:
	lsr_s r0,r0,0x4
L_9330a0:
	st.as r0,[gp,0x3b]
	.global L_9330a4
L_9330a4:
	mov_s r0,r45
L_9330a6:
	bbit0 r0,0x1f,L_9330a4
L_9330aa:
	b_s L_933192
	.global L_9330ac
L_9330ac:
	bl.d L_9331d4
L_9330b0:
	mov_s r0,0x1
L_9330b2:
	b_s L_933192
	.global L_9330b4
L_9330b4:
	ldb_s r0,[gp,-0xef]
L_9330b6:
	cmp_s r0,0x1
L_9330b8:
	bl.eq L_925120
L_9330bc:
	mov_s r0,0x886500
L_9330c2:
	ld_s r0,[r0,0x6c]
L_9330c4:
	bmsk.f 0x0,r0,0x3
L_9330c8:
	beq_s L_9330dc
L_9330ca:
	mov_s r0,blink
L_9330cc:
	mov_s r2,0x1002004
L_9330d2:
	mov_s r1,0x3
L_9330d4:
	bl.d L_925548
L_9330d8:
	mov r3,0x154
	.global L_9330dc
L_9330dc:
	mov_s r0,0x1c000006
L_9330e2:
	mov_s r32,r0
L_9330e4:
	st.ab r0,[r25,0x4]
L_9330e8:
	bclr r25,r25,0xa
L_9330ec:
	mov_s r0,0x460001e8
L_9330f2:
	mov_s r32,r0
L_9330f4:
	st.ab r0,[r25,0x4]
L_9330f8:
	bclr r25,r25,0xa
L_9330fc:
	mov_s r1,0x801458
L_933102:
	ld_s r0,[r1,0x14]
L_933104:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933106:
	st_s r0,[r1,0x14]
	.global L_933108
L_933108:
	mov_s r0,r53
L_93310a:
	bbit0 r0,0x2,L_933108
L_93310e:
	ld_s r0,[gp,-0x44]
L_933110:
	and r0,r0,0xfff0ffff
L_933118:
	bset r1,r0,0x10
L_93311c:
	or r0,r0,0x1d010000
L_933124:
	st.as r1,[gp,-0x11]
L_933128:
	mov_s r32,r0
L_93312a:
	st.ab r0,[r25,0x4]
L_93312e:
	bclr r25,r25,0xa
L_933132:
	nop_s
L_933134:
	nop_s
L_933136:
	nop_s
	.global L_933138
L_933138:
	mov_s r0,r47
L_93313a:
	bbit1 r0,0x0,L_933138
L_93313e:
	mov_s r0,0x4428001e
L_933144:
	mov_s r32,r0
L_933146:
	st.ab r0,[r25,0x4]
L_93314a:
	bclr r25,r25,0xa
L_93314e:
	mov_s r0,0x45000001
L_933154:
	mov_s r32,r0
L_933156:
	st.ab r0,[r25,0x4]
L_93315a:
	bclr r25,r25,0xa
L_93315e:
	mov_s r0,0x460001f1
L_933164:
	mov_s r32,r0
L_933166:
	st.ab r0,[r25,0x4]
L_93316a:
	bclr r25,r25,0xa
L_93316e:
	mov_s r0,0x1e
L_933170:
	bl.d L_92a36c
L_933174:
	st_s r0,[sp,0x4]
	.global L_933176
L_933176:
	mov_s r0,r43
L_933178:
	bbit0 r0,0x1f,L_933176
L_93317c:
	mov_s r0,r51
L_93317e:
	bmsk r1,r0,0x3
L_933182:
	st.as r1,[gp,0x3a]
L_933186:
	lsr_s r0,r0,0x4
L_933188:
	st.as r0,[gp,0x3b]
	.global L_93318c
L_93318c:
	mov_s r0,r45
L_93318e:
	bbit0 r0,0x1f,L_93318c
	.global L_933192
L_933192:
	ld_s r0,[r13]
L_933194:
	cmp_s r0,0x0
L_933196:
	cmp.ne r0,0x2
L_93319a:
	bne_s L_9331ce
L_93319c:
	mov_s r2,0x801438
L_9331a2:
	ldb_s r3,[r2,0x7]
L_9331a4:
	mov_s r0,0x802040
L_9331aa:
	ldw.as r0,[r0,r3]
L_9331ae:
	mov_s r1,0x801a9c
L_9331b4:
	st_s r0,[r1,0x60]
L_9331b6:
	mov_s r0,0x802058
L_9331bc:
	ldw.as r3,[r0,r3]
L_9331c0:
	ldb_s r0,[r2,0xa]
L_9331c2:
	st_s r3,[r1,0x64]
L_9331c4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9331c6:
	mulu64 r0,r3
L_9331ca:
	st mlo,[r1, 0x68]
	.global L_9331ce
L_9331ce:
	b.d L_920284
L_9331d2:
	add_s sp,sp,0x34
