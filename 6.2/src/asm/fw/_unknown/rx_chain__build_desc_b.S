/* rx_chain__build_desc_b @ 0x8e41a8, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_chain__configure_b
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bits__set32_s0_w4, fw_sysassert_fatal, memset0_words, qdesc_cfg__is_override, rx_chain__bits_set16h_s0_w12
 * Глобалы (через gp): 0x8002a8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_chain__build_desc_b
rx_chain__build_desc_b:
	.global L_8e41a8
L_8e41a8:
	push_s blink
L_8e41aa:
	bl L_8c01e0
L_8e41ae:
	mov_s r14,r0
L_8e41b0:
	mov_s r13,r1
L_8e41b2:
	mov_s r15,r2
L_8e41b4:
	bl.d L_8c1cd8
L_8e41b8:
	mov_s r1,0x30
L_8e41ba:
	brhs r13,0x6,L_8e4214
L_8e41be:
	ldb.x r13,[0x802820,r13]
L_8e41c6:
	add r0,pcl,0xa
L_8e41ca:
	add1_s r0,r0,r13
L_8e41cc:
	j_s [r0]
L_8e41ce:
	bl L_8cc2e8
L_8e41d2:
	cmp_s r0,0x0
L_8e41d4:
	mov_s r0,0x2
L_8e41d6:
	bne_s L_8e41e6
	.global L_8e41d8
L_8e41d8:
	mov_s r0,0x1
L_8e41da:
	b_s L_8e41e6
L_8e41dc:
	ld_s r0,[gp,0x124]
L_8e41de:
	breq_s r0,0,L_8e41d8
L_8e41e0:
	mov_s r0,0x4
L_8e41e2:
	b_s L_8e41e6
	.global L_8e41e4
L_8e41e4:
	mov_s r0,0x0
	.global L_8e41e6
L_8e41e6:
	bmsk r1,r0,0x3
L_8e41ea:
	mov_s r0,r14
L_8e41ec:
	bl.d L_8ed370
L_8e41f0:
	mov_s r2,0x0
L_8e41f2:
	mov lp_count,0x8
L_8e41f6:
	stb_s r15,[r14,0x2]
L_8e41f8:
	lp L_8e4210
L_8e41fc:
	mov_s r1,0xfff
L_8e4202:
	add1 r3,r14,r2
L_8e4206:
	add_s r0,r3,0x4
L_8e4208:
	bl.d L_8ed2c8
L_8e420c:
	/* _add_s r2,0x1 */
	.byte 0x01,0xe2
L_8e420e:
	nop_s
	.global L_8e4210
L_8e4210:
	b L_8c024c
	.global L_8e4214
L_8e4214:
	mov_s r0,blink
L_8e4216:
	mov_s r1,0x18
L_8e4218:
	bl.d L_8c9b28
L_8e421c:
	bset_s r1,r1,0xc
L_8e421e:
	b_s L_8e41e4
