/* fsched__slot_half4 @ 0x927d5c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched__time_left_class, l1_fixed_sched_ap__ev4_state4, sends_pmc_mark_aaab02
 * Зовёт сам: fsched__cur_entry_byte1
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__slot_half4
fsched__slot_half4:
	.global L_927d5c
L_927d5c:
	push_s blink
L_927d5e:
	bl L_927db0
L_927d62:
	mov_s r1,0x857700
L_927d68:
	ld_s r1,[r1,0x44]
L_927d6a:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_927d6c:
	add1_s r0,r0,r0
L_927d6e:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_927d70:
	ldw_s r0,[r1,r0]
L_927d72:
	pop_s blink
L_927d74:
	j_s [blink]
L_927d76:
	nop_s
