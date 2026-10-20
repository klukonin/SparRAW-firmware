/* sw_vring__program_ba_win @ 0x8df4cc, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__ba_agreed
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_w_s4_w12, mac_indirect__write_entry, tail_vring__write_macq_desc_8df898
 */
	.section .text.sw_vring__program_ba_win,"ax",@progbits
	.global sw_vring__program_ba_win
sw_vring__program_ba_win:
	.global L_8df4cc
L_8df4cc:
	push_s blink
L_8df4ce:
	bl L_8c02c0
L_8df4d2:
	mov_s r15,r0
L_8df4d4:
	mov_s r14,r1
L_8df4d6:
	mov_s r13,0x84861c
L_8df4dc:
	mov_s r0,r13
L_8df4de:
	bl.d L_8df898
L_8df4e2:
	mov_s r1,r15
L_8df4e4:
	ldw_s r0,[r13,0x2]
L_8df4e6:
	bmsk r1,r14,0xb
L_8df4ea:
	stw_s r0,[r13]
L_8df4ec:
	add r0,r13,0xc
L_8df4f0:
	bl.d L_8e84c8
L_8df4f4:
	mov_s r2,0x1
L_8df4f6:
	mov_s r0,r13
L_8df4f8:
	mov_s r1,r15
L_8df4fa:
	mov_s r3,0x0
L_8df4fc:
	mov_s r4,r3
L_8df4fe:
	mov_s r5,r3
L_8df500:
	mov_s r6,r3
L_8df502:
	bl.d L_8c46a4
L_8df506:
	mov_s r7,r2
L_8df508:
	b L_8c032c
