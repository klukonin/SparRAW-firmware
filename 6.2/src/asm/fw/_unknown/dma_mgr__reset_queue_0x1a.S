/* dma_mgr__reset_queue_0x1a @ 0x8ea15c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__init_pools
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, dma_mgr__queue_state_is_0, dma_mgr__queue_state_is_1, dma_mgr__setup_queue_pair, lmac_if_send_cmd_0x08, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dma_mgr__reset_queue_0x1a
dma_mgr__reset_queue_0x1a:
	.global L_8ea15c
L_8ea15c:
	push_s blink
L_8ea15e:
	bl.d L_8c01e0
L_8ea162:
	mov_s r0,0x1a
L_8ea164:
	bl L_8da544
L_8ea168:
	mov_s r15,r0
L_8ea16a:
	bl.d L_8da528
L_8ea16e:
	mov_s r0,0x1a
L_8ea170:
	mov_s r14,r0
L_8ea172:
	mov_s r13,0x842800
L_8ea178:
	mov_s r0,r13
L_8ea17a:
	bl.d L_8c1cd8
L_8ea17e:
	mov_s r1,0x40
L_8ea180:
	mov_s r0,0x842154
L_8ea186:
	mov_s r1,0x1
L_8ea188:
	mov_s r2,0x842318
L_8ea18e:
	mov_s r3,0x1a
L_8ea190:
	mov r4,0x6
L_8ea194:
	mov_s r5,r13
L_8ea196:
	bl.d L_8d8f28
L_8ea19a:
	mov r6,0x2
L_8ea19e:
	mov_s r0,0x0
L_8ea1a0:
	mov_s r1,r0
L_8ea1a2:
	mov_s r2,0x8
L_8ea1a4:
	mov_s r3,0x1a
L_8ea1a6:
	mov_s r4,r14
L_8ea1a8:
	mov_s r5,r15
L_8ea1aa:
	bl.d L_8dbb60
L_8ea1ae:
	mov_s r6,r0
L_8ea1b0:
	b L_8c024c
