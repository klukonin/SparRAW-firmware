/* __st_r24_to_r13 @ 0x92020c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: config_brp_rf, dma_is_tx_pipe_idle, uc_vector_02
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global __st_r24_to_r13
__st_r24_to_r13:
	.global L_92020c
L_92020c:
	st.a r24,[sp,-0x4]
