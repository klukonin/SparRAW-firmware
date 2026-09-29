/* link_lost_diag__dump_dma @ 0x8c84d4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEBUG DMA: PEDI DIF DEBUG IF: 0x%x
 * Зовут его: link_lost_diag__dump_all
 * Зовёт сам: fw_log_emit1, hwd_dma__read_8812d4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_lost_diag__dump_dma
link_lost_diag__dump_dma:
	.global L_8c84d4
L_8c84d4:
	push_s blink
L_8c84d6:
	bl L_8d07c8
L_8c84da:
	mov_s r1,0x1001114
L_8c84e0:
	mov_s r2,r0
L_8c84e2:
	bl.d L_8dcc10
L_8c84e6:
	mov_s r0,0x20
L_8c84e8:
	pop_s blink
L_8c84ea:
	j_s [blink]
