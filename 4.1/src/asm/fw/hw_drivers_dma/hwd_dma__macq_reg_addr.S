/* hwd_dma__macq_reg_addr @ 0x8cda90, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__2, STREAM_MGR__ADD, stream_mgr__add_bcast_vring
 */
	.section .text.hwd_dma__macq_reg_addr,"ax",@progbits
	.global hwd_dma__macq_reg_addr
hwd_dma__macq_reg_addr:
	.global L_8cda90
L_8cda90:
	asl_s r0,r0,0x8
L_8cda92:
	add_s r0,r0,0x440c100
L_8cda98:
	j_s.d [blink]
L_8cda9a:
	lsr_s r0,r0,0x3
