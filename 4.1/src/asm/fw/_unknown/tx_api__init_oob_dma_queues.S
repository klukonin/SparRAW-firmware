/* tx_api__init_oob_dma_queues @ 0x8e4a30, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__init_oob_pools
 * Зовёт сам: __ld_r13_ret, dma_mgr__setup_queue_pair, memset0_words
 */
	.section .text.tx_api__init_oob_dma_queues,"ax",@progbits
	.global tx_api__init_oob_dma_queues
tx_api__init_oob_dma_queues:
	.global L_8e4a30
L_8e4a30:
	push_s blink
L_8e4a32:
	push_s r13
L_8e4a34:
	mov_s r13,0x843000
L_8e4a3a:
	mov_s r0,r13
L_8e4a3c:
	bl.d L_8c1a78
L_8e4a40:
	mov_s r1,0x40
L_8e4a42:
	mov_s r0,0x8424a0
L_8e4a48:
	mov_s r1,0x0
L_8e4a4a:
	mov_s r2,0x842624
L_8e4a50:
	mov_s r3,0x1e
L_8e4a52:
	mov r4,0x3
L_8e4a56:
	mov_s r5,r13
L_8e4a58:
	bl.d L_8d5dec
L_8e4a5c:
	mov r6,0x2
L_8e4a60:
	b L_8c033c
