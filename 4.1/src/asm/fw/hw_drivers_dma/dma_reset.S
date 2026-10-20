/* dma_reset @ 0x8cdbb0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dma_reset(DO.clr_all) call for descq %d
 * Зовут его: dma_mgr__reset_queue
 * Зовёт сам: __ld_r13_ret, fw_log__emit1
 */
	.section .text.dma_reset,"ax",@progbits
	.global dma_reset
dma_reset:
	.global L_8cdbb0
L_8cdbb0:
	push_s blink
L_8cdbb2:
	push_s r13
L_8cdbb4:
	mov_s r13,r0
L_8cdbb6:
	mov_s r2,0x1018518
L_8cdbbc:
	mov_s r0,0x0
L_8cdbbe:
	mov_s r1,0x1
L_8cdbc0:
	bl.d L_8edfcc
L_8cdbc4:
	mov_s r3,r13
L_8cdbc6:
	mul64 r13,0x380
L_8cdbca:
	mov_s r2,0x0
L_8cdbcc:
	add r0,mlo,0x4409700
L_8cdbd4:
	bmsk r1,r0,0x4
L_8cdbd8:
	lsr_s r0,r0,0x3
L_8cdbda:
	bset r2,r2,r1
L_8cdbde:
	bic r0,r0,0x3
L_8cdbe2:
	st_s r2,[r0]
L_8cdbe4:
	b L_8c033c
