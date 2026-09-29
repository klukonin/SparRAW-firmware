/* rf_utils__auto_fill_8021c8 @ 0x8e33ac, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: marlon_r_if__read_step
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, memcpy_fw, rf_utils_auto_fill
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_utils__auto_fill_8021c8
rf_utils__auto_fill_8021c8:
	.global L_8e33ac
L_8e33ac:
	push_s blink
L_8e33ae:
	bl.d L_8c01e0
L_8e33b2:
	mov_s r2,0x10
L_8e33b4:
	sub_s sp,sp,0x10
L_8e33b6:
	mov_s r14,r0
L_8e33b8:
	mov_s r15,r1
L_8e33ba:
	mov_s r13,sp
L_8e33bc:
	mov_s r1,0x8021c8
L_8e33c2:
	bl.d L_8c0380
L_8e33c6:
	mov_s r0,r13
L_8e33c8:
	stb_s r14,[sp,0x0]
L_8e33ca:
	mov_s r0,r13
L_8e33cc:
	bl.d L_8e3060
L_8e33d0:
	mov_s r1,r15
L_8e33d2:
	b.d L_8c024c
L_8e33d6:
	add_s sp,sp,0x10
