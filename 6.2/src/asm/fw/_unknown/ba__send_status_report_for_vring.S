/* ba__send_status_report_for_vring @ 0x8c41cc, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, send_ba_status_report, vring__active_ring_table
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba__send_status_report_for_vring
ba__send_status_report_for_vring:
	.global L_8c41cc
L_8c41cc:
	push_s blink
L_8c41ce:
	push_s r13
L_8c41d0:
	mov_s r13,r0
L_8c41d2:
	ld_s r0,[r0,0xc]
L_8c41d4:
	brne_s r0,0,L_8c41fc
L_8c41d6:
	ld_s r0,[r13,0x58]
L_8c41d8:
	cmp_s r0,0x0
L_8c41da:
	cmp.eq r1,0x1
L_8c41de:
	bne_s L_8c41ec
L_8c41e0:
	bl L_8cd080
L_8c41e4:
	ld_s r1,[r0]
L_8c41e6:
	ld_s r2,[r1,0x18]
L_8c41e8:
	jl_s.d [r2]
L_8c41ea:
	ldb_s r1,[r13,0x7]
	.global L_8c41ec
L_8c41ec:
	mov_s r0,r13
L_8c41ee:
	ldb_s r1,[r13,0x7]
L_8c41f0:
	mov_s r2,0x1
L_8c41f2:
	mov_s r3,0x0
L_8c41f4:
	mov_s r4,r3
L_8c41f6:
	bl.d L_8e5174
L_8c41fa:
	mov_s r5,r3
	.global L_8c41fc
L_8c41fc:
	b L_8c025c
