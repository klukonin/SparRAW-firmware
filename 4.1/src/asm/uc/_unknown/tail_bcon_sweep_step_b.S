/* tail_bcon_sweep_step_b @ 0x930de4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss__tx_sector_frame, ucode_cmd_0x0c_handler
 * Зовёт сам: bcon_sweep_step_b
 */
	.section .text.tail_bcon_sweep_step_b,"ax",@progbits
	.global tail_bcon_sweep_step_b
tail_bcon_sweep_step_b:
	.global L_930de4
L_930de4:
	mov_s r3,r2
L_930de6:
	b.d L_930dec
L_930dea:
	mov_s r2,0x0
