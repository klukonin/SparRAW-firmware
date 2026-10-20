/* tx_api__init_pools @ 0x8f552c, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, dma_mgr__reset_queue_0x19, dma_mgr__reset_queue_0x1a, fw_sysassert_fatal, llist__init, mem_pool__init, memset0_words, tx_api__reset_state_words, tx_api__tx_complete_cb, tx_macq_api_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__init_pools
tx_api__init_pools:
	.global L_8f552c
L_8f552c:
	push_s blink
L_8f552e:
	bl L_8c01e0
L_8f5532:
	bl.d L_8d986c
L_8f5536:
	sub_s sp,sp,0x8
L_8f5538:
	mov_s r15,0x848020
L_8f553e:
	mov_s r1,0x2920
L_8f5544:
	bl.d L_8c1cd8
L_8f5548:
	mov_s r0,r15
L_8f554a:
	mov_s r13,0x805ac0
L_8f5550:
	mov_s r0,r13
L_8f5552:
	bl.d L_8c1cd8
L_8f5556:
	mov r1,0x524
L_8f555a:
	mov_s r14,sp
L_8f555c:
	breq_s r13,0,L_8f55a8
	.global L_8f555e
L_8f555e:
	st_s r13,[r14]
L_8f5560:
	add_s r13,r13,0x24
L_8f5562:
	st_s r13,[r14,0x4]
L_8f5564:
	ld_s r1,[sp,0x0]
L_8f5566:
	mov_s r0,0xfd
L_8f5568:
	stb_s r0,[r1,0x11]
L_8f556a:
	mov_s r13,0x842304
L_8f5570:
	add r0,r13,0x14
L_8f5574:
	bl.d L_8c1cd8
L_8f5578:
	mov_s r1,0x78
L_8f557a:
	mov_s r0,r13
L_8f557c:
	mov_s r1,r15
L_8f557e:
	mov r2,0x524
L_8f5582:
	bl.d L_8c7cf8
L_8f5586:
	mov_s r3,0x8
L_8f5588:
	bl L_8e9ba0
L_8f558c:
	bl L_8e9ae8
L_8f5590:
	bl L_8ea15c
L_8f5594:
	bl L_8f5270
L_8f5598:
	mov_s r0,0x842148
L_8f559e:
	bl L_8e293c
L_8f55a2:
	b.d L_8c024c
L_8f55a6:
	add_s sp,sp,0x8
	.global L_8f55a8
L_8f55a8:
	mov_s r0,blink
L_8f55aa:
	mov_s r1,0x11d6
L_8f55b0:
	bl L_8c9b28
L_8f55b4:
	b_s L_8f555e
L_8f55b6:
	nop_s
