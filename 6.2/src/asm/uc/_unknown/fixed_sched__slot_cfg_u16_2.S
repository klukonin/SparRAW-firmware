/* fixed_sched__slot_cfg_u16_2 @ 0x927d94, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sends_pmc_mark_aaab02
 * Зовёт сам: fsched__cur_entry_byte1
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fixed_sched__slot_cfg_u16_2
fixed_sched__slot_cfg_u16_2:
	.global L_927d94
L_927d94:
	push_s blink
L_927d96:
	bl L_927db0
L_927d9a:
	mov_s r1,0x857700
L_927da0:
	ld_s r1,[r1,0x44]
L_927da2:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_927da4:
	add1_s r0,r0,r0
L_927da6:
	/* add_s r1,0x2 */
	.byte 0x02,0xe1
L_927da8:
	ldw_s r0,[r1,r0]
L_927daa:
	pop_s blink
L_927dac:
	j_s [blink]
L_927dae:
	nop_s
