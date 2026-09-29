/* dma_reset @ 0x8d0970, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dma_reset(DO.clr_all) call for descq %d
 * Зовут его: dma_mgr__reset_queue
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dma_reset
dma_reset:
	.global L_8d0970
L_8d0970:
	push_s blink
L_8d0972:
	push_s r13
L_8d0974:
	mov_s r13,r0
L_8d0976:
	mov_s r1,0x101d4d0
L_8d097c:
	mov_s r0,0x10
L_8d097e:
	bl.d L_8dcc10
L_8d0982:
	mov_s r2,r13
L_8d0984:
	mul64 r13,0x380
L_8d0988:
	add r0,mlo,0x4409700
L_8d0990:
	lsr_s r0,r0,0x3
L_8d0992:
	bic r1,r0,0x3
L_8d0996:
	mov_s r0,0x1
L_8d0998:
	st_s r0,[r1]
L_8d099a:
	b L_8c025c
L_8d099e:
	nop_s
