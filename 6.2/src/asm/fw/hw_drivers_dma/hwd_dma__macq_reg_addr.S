/* hwd_dma__macq_reg_addr @ 0x8d083c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__2, STREAM_MGR__ADD, stream_mgr__add_bcast_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__macq_reg_addr
hwd_dma__macq_reg_addr:
	.global L_8d083c
L_8d083c:
	asl_s r0,r0,0x8
L_8d083e:
	add_s r0,r0,0x440c100
L_8d0844:
	j_s.d [blink]
L_8d0846:
	lsr_s r0,r0,0x3
