/* sm_pring__all_wb_done_evt @ 0x8c3180, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__build_addba_params, tx_macq__setup
 * Зовёт сам: tx_queue__config_by_mode
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_pring__all_wb_done_evt
sm_pring__all_wb_done_evt:
	.global L_8c3180
L_8c3180:
	add r2,r1,0x20
L_8c3184:
	ldb_s r1,[r0,0xb]
L_8c3186:
	b.d L_8f9fb0
L_8c318a:
	mov_s r0,r2
