/* fsched__drop_station @ 0x92ed00, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__drop_station
fsched__drop_station:
	.global L_92ed00
L_92ed00:
	push_s r13
L_92ed02:
	mov_s r1,0x0
L_92ed04:
	bset r1,r1,r0
L_92ed08:
	not_s r2,r1
L_92ed0a:
	mov_s r3,0x857200
L_92ed10:
	ld_s r1,[r3,0x48]
L_92ed12:
	mov_s r13,0x0
L_92ed14:
	and_s r1,r1,r2
L_92ed16:
	st_s r1,[r3,0x48]
L_92ed18:
	add r1,r0,0x80064c
L_92ed20:
	ld_s r0,[r3,0x4c]
L_92ed22:
	stb_s r13,[r1,0x10]
L_92ed24:
	and_s r0,r0,r2
L_92ed26:
	st_s r0,[r3,0x4c]
L_92ed28:
	j_s.d [blink]
L_92ed2a:
	pop_s r13
