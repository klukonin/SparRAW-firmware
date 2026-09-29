/* if_gain__compute_correction @ 0x8d2780, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_if_gain_fin_est
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 * Глобалы (через gp): 0x80020c
 */
	.section .text.if_gain__compute_correction,"ax",@progbits
	.global if_gain__compute_correction
if_gain__compute_correction:
	.global L_8d2780
L_8d2780:
	push_s blink
L_8d2782:
	bl L_8c02c0
L_8d2786:
	ldb_s r3,[r1,0x2]
L_8d2788:
	mov_s r13,0x842720
L_8d278e:
	ldb.x r15,[r13, 0x7]
L_8d2792:
	ldb_s r2,[r1,0x4]
L_8d2794:
	sub_s r15,r15,0x1d
L_8d2796:
	sexb_s r15,r15
L_8d2798:
	rsub r14,r3,0xffffffe6
L_8d27a0:
	sub r3,r0,0x26
L_8d27a4:
	add_s r2,r2,r14
L_8d27a6:
	sexb_s r3,r3
L_8d27a8:
	sexb_s r2,r2
L_8d27aa:
	sub_s r3,r3,r2
L_8d27ac:
	sexb_s r3,r3
L_8d27ae:
	sub r14,r3,r15
L_8d27b2:
	sexb_s r15,r14
L_8d27b4:
	sub.f r15,r15,0xa
L_8d27b8:
	stb_s r2,[r13,0x5]
L_8d27ba:
	add.mi r15,r15,0x1
L_8d27be:
	asr_s r15,r15
L_8d27c0:
	add_s r15,r15,0xa
L_8d27c2:
	stb_s r0,[r13,0x8]
L_8d27c4:
	stb_s r3,[r13,0x9]
L_8d27c6:
	stb_s r14,[r13,0xa]
L_8d27c8:
	stb_s r15,[r13,0xc]
L_8d27ca:
	ldw_s r0,[r1,0xc]
L_8d27cc:
	extb_s r2,r14
L_8d27ce:
	stw_s r0,[r13,0xe]
L_8d27d0:
	ldb_s r0,[gp,0x9c]
L_8d27d2:
	sub_s r1,r0,0x1
L_8d27d4:
	brlt r2,r1,L_8d27e0
L_8d27d8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d27da:
	cmp_s r2,r0
L_8d27dc:
	mov_s r0,0x1
L_8d27de:
	ble_s L_8d27e2
	.global L_8d27e0
L_8d27e0:
	mov_s r0,0x2
	.global L_8d27e2
L_8d27e2:
	b L_8c032c
L_8d27e6:
	nop_s
