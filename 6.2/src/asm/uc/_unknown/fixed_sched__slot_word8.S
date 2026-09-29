/* fixed_sched__slot_word8 @ 0x927d78, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fixed_sched__check_slot_flag
 * Зовёт сам: fsched__cur_entry_byte1
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fixed_sched__slot_word8
fixed_sched__slot_word8:
	.global L_927d78
L_927d78:
	push_s blink
L_927d7a:
	bl L_927db0
L_927d7e:
	mov_s r1,0x857700
L_927d84:
	ld_s r2,[r1,0x44]
L_927d86:
	asl_s r1,r0,0x2
L_927d88:
	add1_s r1,r1,r1
L_927d8a:
	add r0,r2,0x8
L_927d8e:
	ld_s r0,[r0,r1]
L_927d90:
	pop_s blink
L_927d92:
	j_s [blink]
