/* dma_mgr__reset_queue_0x19 @ 0x8e9ba0, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__init_pools
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, dma_mgr__queue_state_is_0, dma_mgr__queue_state_is_1, dma_mgr__setup_queue_pair, lmac_if_send_cmd_0x08, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dma_mgr__reset_queue_0x19
dma_mgr__reset_queue_0x19:
	.global L_8e9ba0
L_8e9ba0:
	push_s blink
L_8e9ba2:
	bl.d L_8c01e0
L_8e9ba6:
	mov_s r0,0x19
L_8e9ba8:
	bl L_8da544
L_8e9bac:
	mov_s r15,r0
L_8e9bae:
	bl.d L_8da528
L_8e9bb2:
	mov_s r0,0x19
L_8e9bb4:
	mov_s r14,r0
L_8e9bb6:
	mov_s r13,0x840000
L_8e9bbc:
	mov_s r0,r13
L_8e9bbe:
	bl.d L_8c1cd8
L_8e9bc2:
	mov_s r1,0x40
L_8e9bc4:
	mov_s r2,0x842340
L_8e9bca:
	sub2 r0,r2,0x33
L_8e9bce:
	mov_s r1,0x2
L_8e9bd0:
	mov_s r3,0x19
L_8e9bd2:
	mov r4,0x5
L_8e9bd6:
	mov_s r5,r13
L_8e9bd8:
	bl.d L_8d8f28
L_8e9bdc:
	mov_s r6,r1
L_8e9bde:
	mov_s r0,0x0
L_8e9be0:
	mov_s r1,r0
L_8e9be2:
	mov_s r2,0x8
L_8e9be4:
	mov_s r3,0x19
L_8e9be6:
	mov_s r4,r14
L_8e9be8:
	mov_s r5,r15
L_8e9bea:
	bl.d L_8dbb60
L_8e9bee:
	mov_s r6,r0
L_8e9bf0:
	b L_8c024c
