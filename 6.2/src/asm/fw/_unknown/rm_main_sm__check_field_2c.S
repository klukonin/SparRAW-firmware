/* rm_main_sm__check_field_2c @ 0x8c5b08, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__enter_step, vring__reset_pair
 * Зовёт сам: __ld_r13_to_r13_ret, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__check_field_2c
rm_main_sm__check_field_2c:
	.global L_8c5b08
L_8c5b08:
	push_s blink
L_8c5b0a:
	push_s r13
L_8c5b0c:
	mov_s r13,r0
L_8c5b0e:
	ld_s r0,[r0,0x2c]
L_8c5b10:
	breq_s r0,0,L_8c5b1a
L_8c5b12:
	bl L_8c8de0
L_8c5b16:
	mov_s r0,0x0
L_8c5b18:
	st_s r0,[r13,0x2c]
	.global L_8c5b1a
L_8c5b1a:
	ld_s r0,[r13,0x1c]
L_8c5b1c:
	breq_s r0,0,L_8c5b26
L_8c5b1e:
	bl L_8c8de0
L_8c5b22:
	mov_s r0,0x0
L_8c5b24:
	st_s r0,[r13,0x1c]
	.global L_8c5b26
L_8c5b26:
	ld_s r0,[r13,0x28]
L_8c5b28:
	breq_s r0,0,L_8c5b32
L_8c5b2a:
	bl L_8c8de0
L_8c5b2e:
	mov_s r0,0x0
L_8c5b30:
	st_s r0,[r13,0x28]
	.global L_8c5b32
L_8c5b32:
	ld_s r0,[r13,0x24]
L_8c5b34:
	breq_s r0,0,L_8c5b3e
L_8c5b36:
	bl L_8c8de0
L_8c5b3a:
	mov_s r0,0x0
L_8c5b3c:
	st_s r0,[r13,0x24]
	.global L_8c5b3e
L_8c5b3e:
	b L_8c025c
L_8c5b42:
	nop_s
