/* dma_mgr__queue_state_is_1 @ 0x8da528, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__reset_queue_0x19, dma_mgr__reset_queue_0x1a
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dma_mgr__queue_state_is_1
dma_mgr__queue_state_is_1:
	.global L_8da528
L_8da528:
	brhs r0,0x20,L_8da53e
L_8da52c:
	mov_s r1,0x8031c8
L_8da532:
	add1_s r1,r1,r0
L_8da534:
	ldb_s r0,[r1,0x1]
L_8da536:
	cmp_s r0,0x1
L_8da538:
	mov_s r0,0x1
L_8da53a:
	sub_s.ne r0,r0,r0
L_8da53c:
	b_s L_8da540
	.global L_8da53e
L_8da53e:
	mov_s r0,0x0
	.global L_8da540
L_8da540:
	j_s [blink]
L_8da542:
	nop_s
