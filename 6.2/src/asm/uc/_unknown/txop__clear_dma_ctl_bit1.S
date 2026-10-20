/* txop__clear_dma_ctl_bit1 @ 0x92930c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_sta__run_txop
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txop__clear_dma_ctl_bit1
txop__clear_dma_ctl_bit1:
	.global L_92930c
L_92930c:
	mov_s r1,0x881800
L_929312:
	ld.as r0,[r1,0xc9]
L_929316:
	bclr_s r0,r0,0x1
L_929318:
	st.as r0,[r1,0xc9]
L_92931c:
	j_s [blink]
L_92931e:
	nop_s
