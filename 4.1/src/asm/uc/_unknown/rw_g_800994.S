/* rw_g_800994 @ 0x92a5ec, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager_step_a, bti_worker__bti_transmitter_beacon_sweep_flow
 */
	.section .text.rw_g_800994,"ax",@progbits
	.global rw_g_800994
rw_g_800994:
	.global L_92a5ec
L_92a5ec:
	mov_s r1,0x800994
L_92a5f2:
	ldw_s r0,[r1,0x16]
L_92a5f4:
	breq_s r0,0,L_92a600
L_92a5f6:
	ld_s r0,[r1]
L_92a5f8:
	bbit1 r0,0x1,L_92a604
L_92a5fc:
	mov_s r0,0x2
L_92a5fe:
	b_s L_92a602
	.global L_92a600
L_92a600:
	mov_s r0,0x0
	.global L_92a602
L_92a602:
	st_s r0,[r1]
	.global L_92a604
L_92a604:
	j_s [blink]
L_92a606:
	nop_s
