/* basic_sm__step_once @ 0x9288f8, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_ap_mon_if__trigger_bti_to_abft, bi_ap_mon_if__trigger_dti_to_bti
 */
	.section .text.basic_sm__step_once,"ax",@progbits
	.global basic_sm__step_once
basic_sm__step_once:
	.global L_9288f8
L_9288f8:
	ldb r7,[r0, 0x2]
L_9288fc:
	ldb_s r3,[r0]
L_9288fe:
	mulu64 r7,r1
L_928902:
	ld r4,[r0, 0x18]
L_928906:
	add_s r3,r3,mlo
L_928908:
	add2_s r3,r3,r3
L_92890a:
	add_s r3,r3,r4
L_92890c:
	ldb r5,[r3, 0x4]
L_928910:
	mov_s r1,r2
L_928912:
	stb r5,[r0]
L_928916:
	ldb r6,[r3, 0x1]
L_92891a:
	ldb r8,[r3]
L_92891e:
	asl r6,r6,0x8
L_928922:
	or r8,r8,r6
L_928926:
	ldb r6,[r3, 0x2]
L_92892a:
	mov_s r2,0x0
L_92892c:
	asl r6,r6,0x10
L_928930:
	or r8,r8,r6
L_928934:
	ldb r6,[r3, 0x3]
L_928938:
	asl r6,r6,0x18
L_92893c:
	or r8,r8,r6
L_928940:
	j.d [r8]
L_928944:
	mov_s r3,r2
L_928946:
	nop_s
