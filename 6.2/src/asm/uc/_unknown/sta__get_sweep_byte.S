/* sta__get_sweep_byte @ 0x93dad0, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_worker__collect_awake_peers, rx_nav__set_from_duration, tx_initiator_flow_fixed_scheduling
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sta__get_sweep_byte
sta__get_sweep_byte:
	.global L_93dad0
L_93dad0:
	mov_s r2,r0
L_93dad2:
	ld.as r3,[gp,-0x30]
L_93dad6:
	add1 r4,r0,r0
L_93dada:
	sub.f r2,r2,r3
L_93dade:
	ldb r0,[r4,0x80222a]
L_93dae6:
	mov.ne r2,0x1
L_93daea:
	j_s.d [blink]
L_93daec:
	st_s r2,[r1]
L_93daee:
	nop_s
