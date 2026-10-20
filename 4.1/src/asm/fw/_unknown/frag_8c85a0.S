/* frag_8c85a0 @ 0x8c85a0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__on_start
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.frag_8c85a0,"ax",@progbits
	.global frag_8c85a0
frag_8c85a0:
	.global L_8c85a0
L_8c85a0:
	sub_s sp,sp,0x4
L_8c85a2:
	push_s blink
L_8c85a4:
	bl L_8c02c0
L_8c85a8:
	mov_s r13,r0
L_8c85aa:
	ld_s r0,[r0,0x8]
L_8c85ac:
	mov_s r14,r1
L_8c85ae:
	ld_s r2,[r0,0x8]
L_8c85b0:
	jl_s.d [r2]
L_8c85b2:
	mov_s r0,r13
L_8c85b4:
	ld_s r0,[r13,0x8]
L_8c85b6:
	ld_s r2,[r0,0xc]
L_8c85b8:
	mov_s r0,r13
L_8c85ba:
	jl_s.d [r2]
L_8c85bc:
	mov_s r1,r14
L_8c85be:
	mov_s r15,r0
L_8c85c0:
	ld_s r0,[r13,0x8]
L_8c85c2:
	ld_s r2,[r0,0x10]
L_8c85c4:
	mov_s r0,r13
L_8c85c6:
	jl_s.d [r2]
L_8c85c8:
	mov_s r1,r14
L_8c85ca:
	mov_s r0,r15
L_8c85cc:
	mov_s r12,0x8
L_8c85ce:
	.byte 0x63,0x05
