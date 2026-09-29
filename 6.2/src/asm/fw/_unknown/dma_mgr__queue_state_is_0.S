/* dma_mgr__queue_state_is_0 @ 0x8da544, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__reset_queue_0x19, dma_mgr__reset_queue_0x1a
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dma_mgr__queue_state_is_0
dma_mgr__queue_state_is_0:
	.global L_8da544
L_8da544:
	brhs r0,0x20,L_8da55a
L_8da548:
	mov_s r1,0x8031c8
L_8da54e:
	add1_s r1,r1,r0
L_8da550:
	ldb_s r0,[r1,0x1]
L_8da552:
	cmp_s r0,0x0
L_8da554:
	mov_s r0,0x1
L_8da556:
	sub_s.ne r0,r0,r0
L_8da558:
	b_s L_8da55c
	.global L_8da55a
L_8da55a:
	mov_s r0,0x0
	.global L_8da55c
L_8da55c:
	j_s [blink]
L_8da55e:
	nop_s
