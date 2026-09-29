/* tx_initiator__reset_slot_counters @ 0x92c01c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_initiator_step
 */
	.section .text.tx_initiator__reset_slot_counters,"ax",@progbits
	.global tx_initiator__reset_slot_counters
tx_initiator__reset_slot_counters:
	.global L_92c01c
L_92c01c:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92c01e:
	add1_s r0,r0,r0
L_92c020:
	add_s r0,r0,0x8016d8
L_92c026:
	mov_s r2,0x0
L_92c028:
	st_s r2,[r0]
L_92c02a:
	ld_s r1,[r0,0x4]
L_92c02c:
	st_s r1,[r0,0x8]
L_92c02e:
	j_s.d [blink]
L_92c030:
	st_s r2,[r0,0x4]
L_92c032:
	nop_s
