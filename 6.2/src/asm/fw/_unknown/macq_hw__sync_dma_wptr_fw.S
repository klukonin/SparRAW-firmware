/* macq_hw__sync_dma_wptr_fw @ 0x8d4708, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__count_and_sync_dma_wptr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global macq_hw__sync_dma_wptr_fw
macq_hw__sync_dma_wptr_fw:
	.global L_8d4708
L_8d4708:
	mul64 r1,0x380
L_8d470c:
	asl_s r0,r0,0x8
L_8d470e:
	add_s r0,r0,0x440c140
L_8d4714:
	lsr_s r0,r0,0x3
L_8d4716:
	add r1,mlo,0x44098c0
L_8d471e:
	lsr r2,r1,0x3
L_8d4722:
	bic r2,r2,0x3
L_8d4726:
	ld_s r2,[r2]
L_8d4728:
	bmsk_s r1,r1,0x4
L_8d472a:
	lsr_s r2,r2,r1
L_8d472c:
	extw_s r1,r2
L_8d472e:
	bic r0,r0,0x3
L_8d4732:
	st_s r1,[r0]
L_8d4734:
	bset_s r1,r1,0x1f
L_8d4736:
	st_s r1,[r0]
L_8d4738:
	j_s [blink]
L_8d473a:
	nop_s
