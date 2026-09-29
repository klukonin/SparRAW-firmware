/* rx_chain__build_desc @ 0x8e40d4, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_chain__configure
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bits__set32_s0_w12, bits__set32_s0_w4, bits__set32_s16_w12, bits__set32_s16_w7, bits__set32_s4_w4, fw_sysassert_fatal, memset0_words, qdesc_cfg__is_override, rx_chain__bits_set32_s8_w12
 * Глобалы (через gp): 0x8002a8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_chain__build_desc
rx_chain__build_desc:
	.global L_8e40d4
L_8e40d4:
	push_s blink
L_8e40d6:
	bl L_8c01d4
L_8e40da:
	mov_s r14,r0
L_8e40dc:
	mov_s r16,r2
L_8e40de:
	mov_s r17,r3
L_8e40e0:
	mov_s r15,r4
L_8e40e2:
	mov r18,r5
L_8e40e6:
	brne r6,0x0,L_8e4112
L_8e40ea:
	brhs r1,0x6,L_8e4180
L_8e40ee:
	ldb.x r1,[0x802818,r1]
L_8e40f6:
	add r0,pcl,0xa
L_8e40fa:
	add1_s r0,r0,r1
L_8e40fc:
	j_s [r0]
L_8e40fe:
	bl L_8cc2e8
L_8e4102:
	mov_s r13,0x2
L_8e4104:
	brne_s r0,0,L_8e4114
	.global L_8e4106
L_8e4106:
	mov_s r13,0x1
L_8e4108:
	b_s L_8e4114
L_8e410a:
	ld_s r0,[gp,0x124]
L_8e410c:
	breq_s r0,0,L_8e4106
L_8e410e:
	mov_s r13,0x4
L_8e4110:
	b_s L_8e4114
	.global L_8e4112
L_8e4112:
	mov_s r13,0x0
	.global L_8e4114
L_8e4114:
	mov_s r0,r14
L_8e4116:
	bl.d L_8c1cd8
L_8e411a:
	mov_s r1,0x30
L_8e411c:
	bmsk r1,r13,0x3
L_8e4120:
	mov_s r0,r14
L_8e4122:
	bl.d L_8ed370
L_8e4126:
	mov_s r3,0x0
L_8e4128:
	bmsk r1,r16,0x3
L_8e412c:
	bl.d L_8ed520
L_8e4130:
	bmsk r2,r17,0xb
L_8e4134:
	mov_s r1,r2
L_8e4136:
	bl.d L_8ed568
L_8e413a:
	stb_s r3,[r14,0x3]
L_8e413c:
	add r0,r15,r17
L_8e4140:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8e4142:
	bmsk r4,r0,0xb
L_8e4146:
	add_s r0,r14,0x4
L_8e4148:
	mov_s r1,r4
L_8e414a:
	bl.d L_8ed340
L_8e414e:
	cmp_s r13,0x4
L_8e4150:
	mov_s r1,r2
L_8e4152:
	bl L_8ed3e8
L_8e4156:
	add r0,r14,0x8
L_8e415a:
	mov_s r1,r4
L_8e415c:
	bl L_8ed340
L_8e4160:
	bmsk r1,r15,0x6
L_8e4164:
	bl L_8ed40c
L_8e4168:
	stb_s r3,[r14,0xb]
L_8e416a:
	stb_s r3,[r14,0xc]
L_8e416c:
	stb_s r3,[r14,0xd]
L_8e416e:
	stb_s r3,[r14,0xe]
L_8e4170:
	bne_s L_8e4194
L_8e4172:
	/* add_s r15,0x2 */
	.byte 0x02,0xe7
L_8e4174:
	brlt r18,r15,L_8e418c
	.global L_8e4178
L_8e4178:
	b.d L_8c0234
L_8e417c:
	stb r18,[r14, 0xf]
	.global L_8e4180
L_8e4180:
	mov_s r0,blink
L_8e4182:
	mov_s r1,0x18
L_8e4184:
	bl.d L_8c9b28
L_8e4188:
	bset_s r1,r1,0xc
L_8e418a:
	b_s L_8e4112
	.global L_8e418c
L_8e418c:
	mov_s r0,blink
L_8e418e:
	mov_s r1,0x19
L_8e4190:
	bset_s r1,r1,0xc
L_8e4192:
	b_s L_8e41a0
	.global L_8e4194
L_8e4194:
	asl_s r15,r15
L_8e4196:
	brge r18,r15,L_8e4178
L_8e419a:
	mov_s r0,blink
L_8e419c:
	mov_s r1,0x1a
L_8e419e:
	bset_s r1,r1,0xc
	.global L_8e41a0
L_8e41a0:
	bl L_8c9b28
L_8e41a4:
	b_s L_8e4178
L_8e41a6:
	nop_s
