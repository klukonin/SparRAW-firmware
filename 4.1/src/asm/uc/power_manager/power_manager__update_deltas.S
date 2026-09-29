/* power_manager__update_deltas @ 0x92b1f0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_task__run, power_manager__tick_if_elapsed
 */
	.section .text.power_manager__update_deltas,"ax",@progbits
	.global power_manager__update_deltas
power_manager__update_deltas:
	.global L_92b1f0
L_92b1f0:
	mov_s r2,0x800724
L_92b1f6:
	ld_s r1,[r2]
L_92b1f8:
	sub_s r0,r0,r1
L_92b1fa:
	st_s r0,[r2,0x8]
L_92b1fc:
	mov_s r0,0x801458
L_92b202:
	ld_s r0,[r0,0x3c]
L_92b204:
	ld_s r1,[r2,0x4]
L_92b206:
	sub_s r0,r0,r1
L_92b208:
	j_s.d [blink]
L_92b20a:
	st_s r0,[r2,0xc]
