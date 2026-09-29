/* sm_pring__used_slots @ 0x8d9afc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tail_sm_pring__used_slots
 * Глобалы (через gp): 0x8002cc, 0x8003b4
 */
	.section .text.sm_pring__used_slots,"ax",@progbits
	.global sm_pring__used_slots
sm_pring__used_slots:
	.global L_8d9afc
L_8d9afc:
	ld_s r0,[gp,0x244]
L_8d9afe:
	ld_s r1,[r0,0x10]
L_8d9b00:
	ld_s r0,[gp,0x15c]
L_8d9b02:
	j_s.d [blink]
L_8d9b04:
	rsub r0,r0,r1
