/* ba_sm__action_8ea780 @ 0x8ea780, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__action_8ea780
ba_sm__action_8ea780:
	.global L_8ea780
L_8ea780:
	ldb_s r3,[r0]
L_8ea782:
	brhs.d r3,0x5,L_8ea7a2
L_8ea786:
	mov_s r1,0x4
L_8ea788:
	ldb.x r3,[0x802980,r3]
L_8ea790:
	add r2,pcl,0x8
L_8ea794:
	add1_s r2,r2,r3
L_8ea796:
	j_s [r2]
L_8ea798:
	mov_s r1,0x5
L_8ea79a:
	b_s L_8ea7a2
L_8ea79c:
	mov_s r1,0x3
L_8ea79e:
	b_s L_8ea7a2
L_8ea7a0:
	mov_s r1,0x2
	.global L_8ea7a2
L_8ea7a2:
	ld_s r0,[r0,0x40]
L_8ea7a4:
	ld_s r2,[r0,0x68]
L_8ea7a6:
	ld_s r2,[r2,0x14]
L_8ea7a8:
	j_s.d [r2]
L_8ea7aa:
	extw_s r1,r1
