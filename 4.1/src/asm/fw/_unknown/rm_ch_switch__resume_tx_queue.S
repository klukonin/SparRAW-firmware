/* rm_ch_switch__resume_tx_queue @ 0x8e2728, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_ch_switch_sm__switch_on
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fwq_tx__enable_queue
 */
	.section .text.rm_ch_switch__resume_tx_queue,"ax",@progbits
	.global rm_ch_switch__resume_tx_queue
rm_ch_switch__resume_tx_queue:
	.global L_8e2728
L_8e2728:
	push_s blink
L_8e272a:
	bl L_8c02c4
L_8e272e:
	mov_s r13,r0
L_8e2730:
	mov_s r14,0x842410
L_8e2736:
	mov_s r0,r14
L_8e2738:
	bl.d L_8e2624
L_8e273c:
	mov_s r1,r13
L_8e273e:
	mov_s r0,0x842530
L_8e2744:
	bl.d L_8e2624
L_8e2748:
	mov_s r1,r13
L_8e274a:
	add3 r0,r14,0x12
L_8e274e:
	bl.d L_8e2624
L_8e2752:
	mov_s r1,r13
L_8e2754:
	b L_8c0334
