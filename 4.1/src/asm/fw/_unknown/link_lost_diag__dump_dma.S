/* link_lost_diag__dump_dma @ 0x8eac08, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEBUG DMA: PEDI DIF DEBUG IF: 0x%x
 * Зовут его: link_lost_diag__dump_all
 * Зовёт сам: fw_log__emit1, get_reg_8812d4
 */
	.section .text.link_lost_diag__dump_dma,"ax",@progbits
	.global link_lost_diag__dump_dma
link_lost_diag__dump_dma:
	.global L_8eac08
L_8eac08:
	push_s blink
L_8eac0a:
	bl L_8cda1c
L_8eac0e:
	mov_s r2,0x100101c
L_8eac14:
	mov_s r3,r0
L_8eac16:
	mov_s r0,0x0
L_8eac18:
	bl.d L_8edfcc
L_8eac1c:
	mov_s r1,0x2
L_8eac1e:
	pop_s blink
L_8eac20:
	j_s [blink]
L_8eac22:
	nop_s
