/* fsched__slot_byte0 @ 0x927dc8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state2
 * Зовёт сам: fsched__cur_entry_byte1
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__slot_byte0
fsched__slot_byte0:
	.global L_927dc8
L_927dc8:
	push_s blink
L_927dca:
	bl L_927db0
L_927dce:
	mov_s r1,0x857700
L_927dd4:
	ld_s r1,[r1,0x44]
L_927dd6:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_927dd8:
	add1_s r0,r0,r0
L_927dda:
	ldb_s r0,[r1,r0]
L_927ddc:
	pop_s blink
L_927dde:
	j_s [blink]
