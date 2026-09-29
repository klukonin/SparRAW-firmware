/* dma_mgr__reset_queue_0x1a @ 0x8e4d9c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__init_oob_pools
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, dma_mgr__setup_queue_pair, get_g_801488_8d7464, get_g_801488_8d7480, lmac_if_send_cmd_0x08, memset0_words
 */
	.section .text.dma_mgr__reset_queue_0x1a,"ax",@progbits
	.global dma_mgr__reset_queue_0x1a
dma_mgr__reset_queue_0x1a:
	.global L_8e4d9c
L_8e4d9c:
	push_s blink
L_8e4d9e:
	bl.d L_8c02c0
L_8e4da2:
	mov_s r0,0x1a
L_8e4da4:
	bl L_8d7480
L_8e4da8:
	mov_s r15,r0
L_8e4daa:
	bl.d L_8d7464
L_8e4dae:
	mov_s r0,0x1a
L_8e4db0:
	mov_s r14,r0
L_8e4db2:
	mov_s r13,0x842800
L_8e4db8:
	mov_s r0,r13
L_8e4dba:
	bl.d L_8c1a78
L_8e4dbe:
	mov_s r1,0x40
L_8e4dc0:
	mov_s r0,0x842410
L_8e4dc6:
	mov_s r1,0x1
L_8e4dc8:
	mov_s r2,0x8425d4
L_8e4dce:
	mov_s r3,0x1a
L_8e4dd0:
	mov r4,0x6
L_8e4dd4:
	mov_s r5,r13
L_8e4dd6:
	bl.d L_8d5dec
L_8e4dda:
	mov r6,0x2
L_8e4dde:
	mov_s r0,0x0
L_8e4de0:
	mov_s r1,r0
L_8e4de2:
	mov_s r2,0x8
L_8e4de4:
	mov_s r3,0x1a
L_8e4de6:
	mov_s r4,r14
L_8e4de8:
	mov_s r5,r15
L_8e4dea:
	bl.d L_8d8864
L_8e4dee:
	mov_s r6,r0
L_8e4df0:
	b L_8c032c
