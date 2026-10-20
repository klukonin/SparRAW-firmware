/* tail_sm_pring__state_step @ 0x8e2fec, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pring__on_inactivity, sm_pring__notify_vring_state, vring_schd__move_to_ready, vring_schd__prohibit_cids, vring_schd__stop_vring
 * Зовёт сам: sm_pring__state_step
 */
	.section .text.tail_sm_pring__state_step,"ax",@progbits
	.global tail_sm_pring__state_step
tail_sm_pring__state_step:
	.global L_8e2fec
L_8e2fec:
	b.d L_8e5358
