/* marlon_r_if__otp_write @ 0x8f3b00, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   marlon_r_if.cpp
 * Зовут его: otp__write_word
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, marlon_r_if__log_data0
 */
	.section .text.marlon_r_if__otp_write,"ax",@progbits
	.global marlon_r_if__otp_write
marlon_r_if__otp_write:
	.global L_8f3b00
L_8f3b00:
	push_s blink
L_8f3b02:
	bl L_8c02bc
L_8f3b06:
	mov_s r16,r2
L_8f3b08:
	brlt.d r3,0x2,L_8f3b24
L_8f3b0c:
	mov_s r13,r3
L_8f3b0e:
	mov_s r0,blink
L_8f3b10:
	mov_s r2,0x1005078
L_8f3b16:
	mov_s r1,0x133a
L_8f3b1c:
	bl.d L_8c82c0
L_8f3b20:
	mov r3,0x137
	.global L_8f3b24
L_8f3b24:
	cmp_s r13,0x0
L_8f3b26:
	sub_s.ne r0,r0,r0
L_8f3b28:
	mov.ne r1,r16
L_8f3b2c:
	bl.ne.d L_8d12c0
L_8f3b30:
	mov.ne r2,r13
L_8f3b34:
	b L_8c0324
