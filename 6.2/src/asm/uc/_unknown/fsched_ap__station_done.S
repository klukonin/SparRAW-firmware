/* fsched_ap__station_done @ 0x92bddc, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched_ap__station_done
fsched_ap__station_done:
	.global L_92bddc
L_92bddc:
	add_s r3,r0,0x2
L_92bdde:
	ldb r1,[r0, 0x28]
L_92bde2:
	ldb r0,[r0, 0x29]
L_92bde6:
	mov_s r2,0x1
L_92bde8:
	btst r0,r1
L_92bdec:
	mov.eq r0,r2
L_92bdf0:
	beq_s L_92be0a
L_92bdf2:
	add2_s r1,r1,r1
L_92bdf4:
	mov_s r0,0x857700
L_92bdfa:
	ld_s r0,[r0,0x44]
L_92bdfc:
	ldb_s r1,[r3,r1]
L_92bdfe:
	ldb r0,[r0, 0xa4]
L_92be02:
	cmp_s r1,r0
L_92be04:
	mov_s r0,0x1
L_92be06:
	sub.lt r0,r0,r0
	.global L_92be0a
L_92be0a:
	j_s [blink]
