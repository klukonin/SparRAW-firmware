/* field_rw_0x2c__9351f8 @ 0x9351f8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__set_sta_state, fsched_ap__start_slot
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global field_rw_0x2c__9351f8
field_rw_0x2c__9351f8:
	.global L_9351f8
L_9351f8:
	ldb r2,[r0, 0x2c]
L_9351fc:
	bset r2,r2,r1
L_935200:
	j_s.d [blink]
L_935202:
	stb r2,[r0, 0x2c]
L_935206:
	nop_s
