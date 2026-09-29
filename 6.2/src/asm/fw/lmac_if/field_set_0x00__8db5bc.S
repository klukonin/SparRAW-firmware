/* field_set_0x00__8db5bc @ 0x8db5bc, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r13_to_r13_ret, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_set_0x00__8db5bc
field_set_0x00__8db5bc:
	.global L_8db5bc
L_8db5bc:
	push_s blink
L_8db5be:
	push_s r13
L_8db5c0:
	bl.d L_8c3284
L_8db5c4:
	mov_s r13,r0
L_8db5c6:
	st_s r13,[r0]
L_8db5c8:
	mov_s r1,0x3b
L_8db5ca:
	mov_s r2,0x4
L_8db5cc:
	bl.d L_8e5204
L_8db5d0:
	mov_s r3,0x0
L_8db5d2:
	b L_8c025c
L_8db5d6:
	nop_s
