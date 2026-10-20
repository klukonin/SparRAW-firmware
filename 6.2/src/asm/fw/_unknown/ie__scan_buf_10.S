/* ie__scan_buf_10 @ 0x8e27bc, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fixed_sched__start
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bits__set32_s4_w4, macq_desc__read_typed, macq_desc__write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ie__scan_buf_10
ie__scan_buf_10:
	.global L_8e27bc
L_8e27bc:
	push_s blink
L_8e27be:
	bl.d L_8c01e0
L_8e27c2:
	mov_s r2,0x2
L_8e27c4:
	sub_s sp,sp,0x10
L_8e27c6:
	mov_s r14,r0
L_8e27c8:
	mov_s r15,sp
L_8e27ca:
	mov_s r0,r15
L_8e27cc:
	ldb_s r1,[r14,0xa]
L_8e27ce:
	mov_s r13,0x0
L_8e27d0:
	mov_s r3,r13
L_8e27d2:
	mov r4,0x1
L_8e27d6:
	mov r5,r4
L_8e27da:
	bl.d L_8c4f1c
L_8e27de:
	mov r6,0x4
L_8e27e2:
	mov_s r0,sp
L_8e27e4:
	mov_s r1,r13
L_8e27e6:
	bl.d L_8ed520
L_8e27ea:
	mov_s r2,0x2
L_8e27ec:
	mov_s r0,r15
L_8e27ee:
	ldb_s r1,[r14,0xa]
L_8e27f0:
	mov_s r3,r13
L_8e27f2:
	mov_s r4,r13
L_8e27f4:
	mov_s r5,r13
L_8e27f6:
	mov r6,0x1
L_8e27fa:
	bl.d L_8c5010
L_8e27fe:
	mov r7,0x1
L_8e2802:
	b.d L_8c024c
L_8e2806:
	add_s sp,sp,0x10
