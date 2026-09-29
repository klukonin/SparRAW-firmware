/* bi_mode__build_schedule @ 0x927ecc, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 * Зовёт сам: bi_build_schedule_tables, bi_mode__set_1000_units165, rw_g_801e82
 */
	.section .text.bi_mode__build_schedule,"ax",@progbits
	.global bi_mode__build_schedule
bi_mode__build_schedule:
	.global L_927ecc
L_927ecc:
	st.a r13,[sp,-0x8]
L_927ed0:
	st blink,[sp, 0x4]
L_927ed4:
	mov_s r13,r0
L_927ed6:
	mov_s r0,0x1
L_927ed8:
	st r0,[r13, 0x38]
L_927edc:
	bl.d L_927f00
L_927ee0:
	mov r0,r13
L_927ee4:
	bl.d L_9280b4
L_927ee8:
	add r0,r13,0x8
L_927eec:
	bl.d L_928194
L_927ef0:
	add r0,r13,0x24
L_927ef4:
	ld blink,[sp, 0x4]
L_927ef8:
	j.d [blink]
L_927efc:
	ld.ab r13,[sp,0x8]
