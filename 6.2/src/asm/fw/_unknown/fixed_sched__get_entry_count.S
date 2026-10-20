/* fixed_sched__get_entry_count @ 0x8ccec8, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: disc_sm__sw_data_stopped, fixed_sched__start
 * Глобалы (через gp): 0x8001f4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fixed_sched__get_entry_count
fixed_sched__get_entry_count:
	.global L_8ccec8
L_8ccec8:
	j_s.d [blink]
L_8cceca:
	ld_s r0,[gp,0x70]
