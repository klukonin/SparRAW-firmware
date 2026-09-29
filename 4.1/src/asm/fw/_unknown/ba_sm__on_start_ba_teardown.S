/* ba_sm__on_start_ba_teardown @ 0x8e5454, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ba_sm__on_start_ba_teardown,"ax",@progbits
	.global ba_sm__on_start_ba_teardown
ba_sm__on_start_ba_teardown:
L_8e5454:
	ldb_s r3,[r0]
L_8e5456:
	brhs.d r3,0x5,L_8e5476
L_8e545a:
	mov_s r1,0x4
L_8e545c:
	ldb.x r3,[0x8023f8,r3]
L_8e5464:
	add r2,pcl,0x8
L_8e5468:
	add1_s r2,r2,r3
L_8e546a:
	j_s [r2]
L_8e546c:
	mov_s r1,0x5
L_8e546e:
	b_s L_8e5476
L_8e5470:
	mov_s r1,0x3
L_8e5472:
	b_s L_8e5476
L_8e5474:
	mov_s r1,0x2
	.global L_8e5476
L_8e5476:
	ld r0,[r0, 0xac]
L_8e547a:
	ld r2,[r0, 0xd4]
L_8e547e:
	ld_s r2,[r2,0x14]
L_8e5480:
	j_s.d [r2]
L_8e5482:
	extw_s r1,r1
