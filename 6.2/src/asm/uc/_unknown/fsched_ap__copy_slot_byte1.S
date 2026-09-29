/* fsched_ap__copy_slot_byte1 @ 0x92ec28, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state4
 * Зовёт сам: fsched__cur_entry_byte1
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched_ap__copy_slot_byte1
fsched_ap__copy_slot_byte1:
	.global L_92ec28
L_92ec28:
	push_s blink
L_92ec2a:
	mov_s r2,r0
L_92ec2c:
	ldb r3,[r0, 0x28]
L_92ec30:
	bl.d L_927db0
L_92ec34:
	add2_s r3,r3,r3
L_92ec36:
	mov_s r1,0x857700
L_92ec3c:
	ld_s r1,[r1,0x44]
L_92ec3e:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92ec40:
	add1_s r0,r0,r0
L_92ec42:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92ec44:
	ldb_s r0,[r1,r0]
L_92ec46:
	/* add_s r3,0x3 */
	.byte 0x03,0xe3
L_92ec48:
	add_s r3,r3,r2
L_92ec4a:
	stb_s r0,[r3]
L_92ec4c:
	pop_s blink
L_92ec4e:
	j_s [blink]
