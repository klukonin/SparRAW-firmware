/* rx_macq__setup @ 0x8d93a0, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_macq__init, rx_macq__setup_default, wmi_cfg_rx_chain
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, rx_chain__configure_b, rx_macq__get_cfg_word, rx_macq__program_ba_win, rx_macq__program_desc_848018, rx_macq__program_offload_desc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_macq__setup
rx_macq__setup:
	.global L_8d93a0
L_8d93a0:
	push_s blink
L_8d93a2:
	bl L_8c01e0
L_8d93a6:
	mov_s r13,r0
L_8d93a8:
	mov_s r0,r2
L_8d93aa:
	mov_s r15,r3
L_8d93ac:
	mov_s r2,r4
L_8d93ae:
	mov_s r3,r5
L_8d93b0:
	mov r4,r6
L_8d93b4:
	mov_s r14,r7
L_8d93b6:
	stb_s r1,[r13]
L_8d93b8:
	stb_s r0,[r13,0x1]
L_8d93ba:
	stw_s r14,[r13,0x2]
L_8d93bc:
	mov_s r1,0x0
L_8d93be:
	ld_s r0,[sp,0x10]
L_8d93c0:
	stb_s r1,[r13,0x4]
L_8d93c2:
	st_s r0,[r13,0x8]
L_8d93c4:
	st_s r1,[r13,0xc]
L_8d93c6:
	mov_s r0,r13
L_8d93c8:
	mov_s r1,r15
L_8d93ca:
	bl.d L_8e37fc
L_8d93ce:
	mov_s r5,r14
L_8d93d0:
	bl L_8cc3c4
L_8d93d4:
	ldb_s r1,[r13,0x1]
L_8d93d6:
	cmp_s r1,0x0
L_8d93d8:
	cmp.ne r1,0x5
L_8d93dc:
	cmp.ne r1,0x1
L_8d93e0:
	bne_s L_8d93e4
L_8d93e2:
	mov_s r0,0x0
	.global L_8d93e4
L_8d93e4:
	cmp_s r1,0x3
L_8d93e6:
	mov r4,0x1
L_8d93ea:
	mov.ne r4,r0
L_8d93ee:
	mov_s r0,r13
L_8d93f0:
	mov_s r1,r15
L_8d93f2:
	mov_s r2,0x0
L_8d93f4:
	bl.d L_8df908
L_8d93f8:
	mov_s r3,r2
L_8d93fa:
	bl.d L_8df65c
L_8d93fe:
	mov_s r0,r13
L_8d9400:
	mov_s r0,r13
L_8d9402:
	bl.d L_8c4508
L_8d9406:
	mov_s r1,r14
L_8d9408:
	b L_8c024c
