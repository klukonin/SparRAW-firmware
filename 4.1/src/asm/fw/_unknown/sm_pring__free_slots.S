/* sm_pring__free_slots @ 0x8d9ad8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring, sm_pring__slot_optimized, tail_sm_pring__free_slots
 * Глобалы (через gp): 0x8002c8, 0x8003b4
 */
	.section .text.sm_pring__free_slots,"ax",@progbits
	.global sm_pring__free_slots
sm_pring__free_slots:
	.global L_8d9ad8
L_8d9ad8:
	ld.as r2,[gp,0x91]
L_8d9adc:
	ld_s r0,[gp,0x158]
L_8d9ade:
	ld r1,[r2, 0x88]
L_8d9ae2:
	sub_s r1,r1,r0
L_8d9ae4:
	ld_s r0,[r2,0x20]
L_8d9ae6:
	j_s.d [blink]
L_8d9ae8:
	rsub r0,r0,r1
