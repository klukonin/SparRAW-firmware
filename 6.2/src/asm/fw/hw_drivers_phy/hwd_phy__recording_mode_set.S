/* hwd_phy__recording_mode_set @ 0x8d1fc8, 400 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__recording_mode_set
hwd_phy__recording_mode_set:
	.global L_8d1fc8
L_8d1fc8:
	push_s blink
L_8d1fca:
	bl L_8c01cc
L_8d1fce:
	mov_s r20,r1
L_8d1fd0:
	mov_s r19,r2
L_8d1fd2:
	mov_s r15,r3
L_8d1fd4:
	mov r17,r4
L_8d1fd8:
	mov_s r2,0x1
L_8d1fda:
	mov_s r1,0x0
L_8d1fdc:
	cmp_s r0,0x1
L_8d1fde:
	mov.le r16,r1
L_8d1fe2:
	mov.gt r16,r2
L_8d1fe6:
	mov_s r1,0x1
L_8d1fe8:
	sub.le r1,r1,r1
L_8d1fec:
	mov_s r14,0x1
L_8d1fee:
	add1 r13,r14,r1
L_8d1ff2:
	cmp_s r0,0x2
L_8d1ff4:
	mov.le r14,0x0
L_8d1ff8:
	mov.gt r13,0x7
L_8d1ffc:
	bclr.f 0x0,r16,0x0
L_8d2000:
	bne_s L_8d2046
	.global L_8d2002
L_8d2002:
	bclr.f 0x0,r14,0x0
L_8d2006:
	bne_s L_8d2050
	.global L_8d2008
L_8d2008:
	mov_s r0,0x880180
L_8d200e:
	ld_s r2,[r0,0x60]
L_8d2010:
	asl r1,r16,0x7
L_8d2014:
	bic r2,r2,0xc0
L_8d2018:
	bset_s r2,r2,0x6
L_8d201a:
	or_s r1,r1,r2
L_8d201c:
	bclr_s r1,r1,0x8
L_8d201e:
	asl_s r14,r14,0x8
L_8d2020:
	or_s r14,r14,r1
L_8d2022:
	st_s r14,[r0,0x60]
L_8d2024:
	bic.f 0x0,r13,0x7
L_8d2028:
	bne_s L_8d205a
	.global L_8d202a
L_8d202a:
	mov_s r1,0x883880
L_8d2030:
	ld_s r0,[r1,0x28]
L_8d2032:
	bic r0,r0,0x7
L_8d2036:
	or_s r13,r13,r0
L_8d2038:
	st_s r13,[r1,0x28]
L_8d203a:
	brne r20,0x0,L_8d2064
L_8d203e:
	mov_s r0,0x0
L_8d2040:
	mov_s r18,r0
L_8d2042:
	mov_s r16,r0
L_8d2044:
	b_s L_8d208a
	.global L_8d2046
L_8d2046:
	mov_s r0,blink
L_8d2048:
	bl.d L_8c9b28
L_8d204c:
	mov_s r1,0xb0
L_8d204e:
	b_s L_8d2002
	.global L_8d2050
L_8d2050:
	mov_s r0,blink
L_8d2052:
	bl.d L_8c9b28
L_8d2056:
	mov_s r1,0xb1
L_8d2058:
	b_s L_8d2008
	.global L_8d205a
L_8d205a:
	mov_s r0,blink
L_8d205c:
	bl.d L_8c9b28
L_8d2060:
	mov_s r1,0xac
L_8d2062:
	b_s L_8d202a
	.global L_8d2064
L_8d2064:
	mov_s r2,0x883000
L_8d206a:
	ld_s r0,[r2,0x10]
L_8d206c:
	bmsk r16,r0,0x0
L_8d2070:
	ld_s r0,[r2,0x10]
L_8d2072:
	lsr_s r0,r0,0x2
L_8d2074:
	bmsk r18,r0,0x0
L_8d2078:
	ld_s r0,[r2,0x10]
L_8d207a:
	bclr_s r0,r0,0x0
L_8d207c:
	st_s r0,[r2,0x10]
L_8d207e:
	ld_s r0,[r2,0x10]
L_8d2080:
	bset_s r0,r0,0x2
L_8d2082:
	st_s r0,[r2,0x10]
L_8d2084:
	ld_s r0,[r2,0x10]
L_8d2086:
	bset_s r0,r0,0x0
L_8d2088:
	st_s r0,[r2,0x10]
	.global L_8d208a
L_8d208a:
	ld_s r0,[r1,0x24]
L_8d208c:
	cmp_s r15,0x4
L_8d208e:
	bclr.eq r0,r0,0x0
L_8d2092:
	bset.ne r0,r0,0x0
L_8d2096:
	st_s r0,[r1,0x24]
L_8d2098:
	brne r15,0xb,L_8d20a4
L_8d209c:
	ld_s r0,[r1,0x24]
L_8d209e:
	bset_s r15,r15,0xf
L_8d20a0:
	bclr_s r0,r0,0x0
L_8d20a2:
	st_s r0,[r1,0x24]
	.global L_8d20a4
L_8d20a4:
	mov_s r13,0xffff0000
L_8d20aa:
	tst_s r15,r13
L_8d20ac:
	bne_s L_8d2126
	.global L_8d20ae
L_8d20ae:
	mov_s r14,0x883580
L_8d20b4:
	ld_s r0,[r14,0x14]
L_8d20b6:
	tst r19,r13
L_8d20ba:
	and_s r0,r0,r13
L_8d20bc:
	or_s r0,r0,r15
L_8d20be:
	st_s r0,[r14,0x14]
L_8d20c0:
	bne_s L_8d2130
	.global L_8d20c2
L_8d20c2:
	ld_s r0,[r14,0x1c]
L_8d20c4:
	and_s r0,r0,r13
L_8d20c6:
	or r0,r0,r19
L_8d20ca:
	st_s r0,[r14,0x1c]
L_8d20cc:
	ld_s r0,[r14,0x18]
L_8d20ce:
	and_s r0,r0,r13
L_8d20d0:
	st_s r0,[r14,0x18]
L_8d20d2:
	brne r17,0x1f,L_8d20e0
L_8d20d6:
	ld_s r0,[r14,0x18]
L_8d20d8:
	and_s r0,r0,r13
L_8d20da:
	or r0,r0,0x1e
L_8d20de:
	st_s r0,[r14,0x18]
	.global L_8d20e0
L_8d20e0:
	tst r17,r13
L_8d20e4:
	bne_s L_8d213a
	.global L_8d20e6
L_8d20e6:
	ld_s r0,[r14,0x18]
L_8d20e8:
	and_s r0,r0,r13
L_8d20ea:
	or r0,r0,r17
L_8d20ee:
	st_s r0,[r14,0x18]
L_8d20f0:
	breq r20,0x0,L_8d2122
L_8d20f4:
	mov_s r13,0x883000
L_8d20fa:
	ld_s r0,[r13,0x10]
L_8d20fc:
	bclr.f 0x0,r18,0x0
L_8d2100:
	bclr_s r0,r0,0x0
L_8d2102:
	st_s r0,[r13,0x10]
L_8d2104:
	bne_s L_8d2144
	.global L_8d2106
L_8d2106:
	ld_s r0,[r13,0x10]
L_8d2108:
	asl r1,r18,0x2
L_8d210c:
	bclr_s r0,r0,0x2
L_8d210e:
	or_s r0,r0,r1
L_8d2110:
	st_s r0,[r13,0x10]
L_8d2112:
	bclr.f 0x0,r16,0x0
L_8d2116:
	bne_s L_8d214e
	.global L_8d2118
L_8d2118:
	ld_s r0,[r13,0x10]
L_8d211a:
	bclr_s r0,r0,0x0
L_8d211c:
	or r0,r0,r16
L_8d2120:
	st_s r0,[r13,0x10]
	.global L_8d2122
L_8d2122:
	b L_8c0224
	.global L_8d2126
L_8d2126:
	mov_s r0,blink
L_8d2128:
	bl.d L_8c9b28
L_8d212c:
	mov_s r1,0xac
L_8d212e:
	b_s L_8d20ae
	.global L_8d2130
L_8d2130:
	mov_s r0,blink
L_8d2132:
	bl.d L_8c9b28
L_8d2136:
	mov_s r1,0xac
L_8d2138:
	b_s L_8d20c2
	.global L_8d213a
L_8d213a:
	mov_s r0,blink
L_8d213c:
	bl.d L_8c9b28
L_8d2140:
	mov_s r1,0xac
L_8d2142:
	b_s L_8d20e6
	.global L_8d2144
L_8d2144:
	mov_s r0,blink
L_8d2146:
	bl.d L_8c9b28
L_8d214a:
	mov_s r1,0xac
L_8d214c:
	b_s L_8d2106
	.global L_8d214e
L_8d214e:
	mov_s r0,blink
L_8d2150:
	bl.d L_8c9b28
L_8d2154:
	mov_s r1,0xac
L_8d2156:
	b_s L_8d2118
