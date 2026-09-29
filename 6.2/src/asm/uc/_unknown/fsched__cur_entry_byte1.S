/* fsched__cur_entry_byte1 @ 0x927db0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fixed_sched__slot_cfg_u16_2, fixed_sched__slot_word8, fsched__slot_byte0, fsched__slot_half4, fsched_ap__copy_slot_byte1, l1_fixed_sched_ap__ev4_state2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__cur_entry_byte1
fsched__cur_entry_byte1:
	.global L_927db0
L_927db0:
	ldb r1,[r0, 0x28]
L_927db4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_927db6:
	add2_s r1,r1,r1
L_927db8:
	j_s.d [blink]
L_927dba:
	ldb_s r0,[r0,r1]
