/* vring__program_macq_and_ba @ 0x8ea9d4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, macq_desc__read, macq_desc__write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__program_macq_and_ba
vring__program_macq_and_ba:
	.global L_8ea9d4
L_8ea9d4:
	push_s blink
L_8ea9d6:
	bl.d L_8c01dc
L_8ea9da:
	mov_s r3,0x0
L_8ea9dc:
	sub_s sp,sp,0x10
L_8ea9de:
	mov_s r14,r0
L_8ea9e0:
	mov_s r13,r1
L_8ea9e2:
	mov_s r16,r2
L_8ea9e4:
	mov_s r15,sp
L_8ea9e6:
	mov_s r0,r15
L_8ea9e8:
	ldb_s r1,[r14,0xa]
L_8ea9ea:
	mov_s r2,0x2
L_8ea9ec:
	bl.d L_8c50f8
L_8ea9f0:
	mov r4,0x1
L_8ea9f4:
	stw r13,[sp]
L_8ea9f8:
	stw r13,[sp, 0x2]
L_8ea9fc:
	stw r13,[sp, 0x6]
L_8eaa00:
	stw r16,[sp, 0x4]
L_8eaa04:
	mov_s r0,r15
L_8eaa06:
	ldb_s r1,[r14,0xa]
L_8eaa08:
	mov_s r2,0x2
L_8eaa0a:
	mov_s r3,0x0
L_8eaa0c:
	mov_s r4,r3
L_8eaa0e:
	mov_s r5,r3
L_8eaa10:
	mov_s r6,r3
L_8eaa12:
	bl.d L_8c5010
L_8eaa16:
	mov r7,0x1
L_8eaa1a:
	b.d L_8c0244
L_8eaa1e:
	add_s sp,sp,0x10
