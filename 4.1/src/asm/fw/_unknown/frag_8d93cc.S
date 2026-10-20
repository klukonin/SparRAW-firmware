/* frag_8d93cc @ 0x8d93cc, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib_bb_gain_rows
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, frag_8d2744
 */
	.section .text.frag_8d93cc,"ax",@progbits
	.global frag_8d93cc
frag_8d93cc:
	.global L_8d93cc
L_8d93cc:
	sub_s sp,sp,0x1c
L_8d93ce:
	push_s blink
L_8d93d0:
	bl.d L_8c02c0
L_8d93d4:
	mov_s r1,r3
L_8d93d6:
	sub_s sp,sp,0x10
L_8d93d8:
	mov_s r13,r4
L_8d93da:
	mov_s r3,r5
L_8d93dc:
	mov r4,r6
L_8d93e0:
	mov r5,r7
L_8d93e4:
	mov_s r0,r2
L_8d93e6:
	ld r6,[sp, 0x3c]
L_8d93ea:
	ld r7,[sp, 0x40]
L_8d93ee:
	ld_s r14,[sp,0x48]
L_8d93f0:
	ld_s r15,[sp,0x44]
L_8d93f2:
	st_s r15,[sp,0x0]
L_8d93f4:
	st_s r14,[sp,0x4]
L_8d93f6:
	add_s r14,sp,0xc
L_8d93f8:
	st_s r14,[sp,0x8]
L_8d93fa:
	bl.d L_8d2744
L_8d93fe:
	mov_s r2,r13
L_8d9400:
	mov_s r12,0x20
L_8d9402:
	b.d L_8c032e
L_8d9406:
	add_s sp,sp,0x10
