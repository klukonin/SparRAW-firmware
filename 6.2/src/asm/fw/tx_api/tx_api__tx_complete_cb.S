/* tx_api__tx_complete_cb @ 0x8e9ae8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__init_pools
 * Зовёт сам: __ld_r13_to_r13_ret, dma_mgr__setup_queue_pair, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__tx_complete_cb
tx_api__tx_complete_cb:
	.global L_8e9ae8
L_8e9ae8:
	push_s blink
L_8e9aea:
	push_s r13
L_8e9aec:
	mov_s r13,0x843000
L_8e9af2:
	mov_s r0,r13
L_8e9af4:
	bl.d L_8c1cd8
L_8e9af8:
	mov_s r1,0x40
L_8e9afa:
	mov_s r0,0x8421e4
L_8e9b00:
	mov_s r1,0x0
L_8e9b02:
	mov_s r2,0x842368
L_8e9b08:
	mov_s r3,0x1e
L_8e9b0a:
	mov r4,0x3
L_8e9b0e:
	mov_s r5,r13
L_8e9b10:
	bl.d L_8d8f28
L_8e9b14:
	mov r6,0x2
L_8e9b18:
	b L_8c025c
