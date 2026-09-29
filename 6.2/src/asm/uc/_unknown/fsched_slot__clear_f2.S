/* fsched_slot__clear_f2 @ 0x92ec18, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched_slot__clear_f2
fsched_slot__clear_f2:
	.global L_92ec18
L_92ec18:
	ldb r1,[r0, 0x28]
L_92ec1c:
	mov_s r2,0x0
L_92ec1e:
	add2_s r1,r1,r1
L_92ec20:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_92ec22:
	add_s r0,r0,r1
L_92ec24:
	j_s.d [blink]
L_92ec26:
	stb_s r2,[r0]
