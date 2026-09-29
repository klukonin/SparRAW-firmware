/* power_manager__snapshot_marks @ 0x92b20c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_task__run, power_manager__tick_if_elapsed
 */
	.section .text.power_manager__snapshot_marks,"ax",@progbits
	.global power_manager__snapshot_marks
power_manager__snapshot_marks:
	.global L_92b20c
L_92b20c:
	mov_s r1,0x801458
L_92b212:
	ld_s r2,[r1,0x3c]
L_92b214:
	mov_s r1,0x800724
L_92b21a:
	st_s r2,[r1,0x4]
L_92b21c:
	j_s.d [blink]
L_92b21e:
	st_s r0,[r1]
