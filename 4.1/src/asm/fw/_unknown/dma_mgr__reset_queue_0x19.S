/* dma_mgr__reset_queue_0x19 @ 0x8e4b00, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__init_oob_pools
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, dma_mgr__setup_queue_pair, get_g_801488_8d7464, get_g_801488_8d7480, lmac_if_send_cmd_0x08, memset0_words
 */
	.section .text.dma_mgr__reset_queue_0x19,"ax",@progbits
	.global dma_mgr__reset_queue_0x19
dma_mgr__reset_queue_0x19:
	.global L_8e4b00
L_8e4b00:
	push_s blink
L_8e4b02:
	bl.d L_8c02c0
L_8e4b06:
	mov_s r0,0x19
L_8e4b08:
	bl L_8d7480
L_8e4b0c:
	mov_s r15,r0
L_8e4b0e:
	bl.d L_8d7464
L_8e4b12:
	mov_s r0,0x19
L_8e4b14:
	mov_s r14,r0
L_8e4b16:
	mov_s r13,0x840000
L_8e4b1c:
	mov_s r0,r13
L_8e4b1e:
	bl.d L_8c1a78
L_8e4b22:
	mov_s r1,0x40
L_8e4b24:
	mov_s r2,0x8425fc
L_8e4b2a:
	sub2 r0,r2,0x33
L_8e4b2e:
	mov_s r1,0x2
L_8e4b30:
	mov_s r3,0x19
L_8e4b32:
	mov r4,0x5
L_8e4b36:
	mov_s r5,r13
L_8e4b38:
	bl.d L_8d5dec
L_8e4b3c:
	mov_s r6,r1
L_8e4b3e:
	mov_s r0,0x0
L_8e4b40:
	mov_s r1,r0
L_8e4b42:
	mov_s r2,0x8
L_8e4b44:
	mov_s r3,0x19
L_8e4b46:
	mov_s r4,r14
L_8e4b48:
	mov_s r5,r15
L_8e4b4a:
	bl.d L_8d8864
L_8e4b4e:
	mov_s r6,r0
L_8e4b50:
	b L_8c032c
