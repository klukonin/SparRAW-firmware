/* fsched__log_phase @ 0x92b398, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap_sm, l1_fixed_sched_sta_sm
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__log_phase
fsched__log_phase:
	.global L_92b398
L_92b398:
	ldb r3,[gp, -0xee]
L_92b39c:
	mov_s r1,0x80064c
L_92b3a2:
	ld_s r2,[r1]
L_92b3a4:
	mov_s r1,0x8007d4
L_92b3aa:
	add2_s r1,r1,r3
L_92b3ac:
	stb_s r2,[r1]
L_92b3ae:
	stb_s r0,[r1,0x1]
L_92b3b0:
	mov_s r0,0xff
L_92b3b2:
	stb_s r0,[r1,0x3]
L_92b3b4:
	mov_s r0,0x0
L_92b3b6:
	j_s.d [blink]
L_92b3b8:
	stb_s r0,[r1,0x2]
L_92b3ba:
	nop_s
