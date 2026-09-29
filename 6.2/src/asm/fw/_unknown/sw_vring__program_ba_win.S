/* sw_vring__program_ba_win @ 0x8e4094, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__ba_agreed
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bits__set32_s4_w12, macq_desc__read_t1_w0_n2, macq_desc__write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sw_vring__program_ba_win
sw_vring__program_ba_win:
	.global L_8e4094
L_8e4094:
	push_s blink
L_8e4096:
	bl L_8c01e0
L_8e409a:
	mov_s r15,r0
L_8e409c:
	mov_s r14,r1
L_8e409e:
	mov_s r13,0x847fc8
L_8e40a4:
	mov_s r0,r13
L_8e40a6:
	bl.d L_8e4430
L_8e40aa:
	mov_s r1,r15
L_8e40ac:
	ldw_s r0,[r13,0x2]
L_8e40ae:
	bmsk r1,r14,0xb
L_8e40b2:
	stw_s r0,[r13]
L_8e40b4:
	add r0,r13,0xc
L_8e40b8:
	bl.d L_8ed4f0
L_8e40bc:
	mov_s r2,0x1
L_8e40be:
	mov_s r0,r13
L_8e40c0:
	mov_s r1,r15
L_8e40c2:
	mov_s r3,0x0
L_8e40c4:
	mov_s r4,r3
L_8e40c6:
	mov_s r5,r3
L_8e40c8:
	mov_s r6,r3
L_8e40ca:
	bl.d L_8c5010
L_8e40ce:
	mov_s r7,r2
L_8e40d0:
	b L_8c024c
