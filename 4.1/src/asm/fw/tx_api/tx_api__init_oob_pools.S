/* tx_api__init_oob_pools @ 0x8ed308, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/tx_api.h
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, dma_mgr__reset_queue_0x19, dma_mgr__reset_queue_0x1a, fw_sysassert_fatal, llist__init, mem_pool__init, memset0_words, set_g_8000b0_x3, tx_api__init_oob_dma_queues, tx_macq_api_step
 */
	.section .text.tx_api__init_oob_pools,"ax",@progbits
	.global tx_api__init_oob_pools
tx_api__init_oob_pools:
	.global L_8ed308
L_8ed308:
	push_s blink
L_8ed30a:
	bl L_8c02c0
L_8ed30e:
	bl.d L_8d67cc
L_8ed312:
	sub_s sp,sp,0x8
L_8ed314:
	mov_s r15,0x848674
L_8ed31a:
	mov_s r1,0x28e0
L_8ed320:
	bl.d L_8c1a78
L_8ed324:
	mov_s r0,r15
L_8ed326:
	mov_s r13,0x805da8
L_8ed32c:
	mov_s r0,r13
L_8ed32e:
	bl.d L_8c1a78
L_8ed332:
	mov_s r1,0x4
L_8ed334:
	mov_s r14,sp
L_8ed336:
	breq_s r13,0,L_8ed382
	.global L_8ed338
L_8ed338:
	st_s r13,[r14]
L_8ed33a:
	add_s r13,r13,0x1c
L_8ed33c:
	st_s r13,[r14,0x4]
L_8ed33e:
	ld_s r1,[sp,0x0]
L_8ed340:
	mov_s r0,0xfd
L_8ed342:
	stb_s r0,[r1,0x11]
L_8ed344:
	mov_s r13,0x8425c0
L_8ed34a:
	add r0,r13,0x14
L_8ed34e:
	bl.d L_8c1a78
L_8ed352:
	mov_s r1,0x78
L_8ed354:
	mov_s r0,r13
L_8ed356:
	mov_s r1,r15
L_8ed358:
	mov r2,0x51c
L_8ed35c:
	bl.d L_8c6c70
L_8ed360:
	mov_s r3,0x8
L_8ed362:
	bl L_8e4b00
L_8ed366:
	bl L_8e4a30
L_8ed36a:
	bl L_8e4d9c
L_8ed36e:
	bl L_8ed0c0
L_8ed372:
	mov_s r0,0x842404
L_8ed378:
	bl L_8de5c4
L_8ed37c:
	b.d L_8c032c
L_8ed380:
	add_s sp,sp,0x8
	.global L_8ed382
L_8ed382:
	mov_s r0,blink
L_8ed384:
	mov_s r2,0x1014d54
L_8ed38a:
	mov_s r1,0x11d6
L_8ed390:
	bl.d L_8c82c0
L_8ed394:
	mov_s r3,0xaa
L_8ed396:
	b_s L_8ed338
