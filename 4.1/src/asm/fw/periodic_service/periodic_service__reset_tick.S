/* periodic_service__reset_tick @ 0x8c4d78, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   periodic_service.cpp
 * Зовёт сам: __ld_r13_ret, fw_read_timer, fw_sysassert_fatal
 */
	.section .text.periodic_service__reset_tick,"ax",@progbits
	.global periodic_service__reset_tick
periodic_service__reset_tick:
L_8c4d78:
	/* b_s 0x008c4d40 */
	.byte 0xe4,0xf1
	.global sub_8c4d7a
sub_8c4d7a:
L_8c4d7a:
	nop_s
L_8c4d7c:
	push_s blink
L_8c4d7e:
	push_s r13
L_8c4d80:
	mov.f r13,r0
L_8c4d84:
	beq_s L_8c4d9a
	.global L_8c4d86
L_8c4d86:
	bl L_8e4694
L_8c4d8a:
	mov_s r0,0x0
L_8c4d8c:
	st_s r0,[r13,0x10]
L_8c4d8e:
	ld_s r0,[r13,0x2c]
L_8c4d90:
	ld_s r1,[r0,0x10]
L_8c4d92:
	jl_s.d [r1]
L_8c4d94:
	mov_s r0,r13
L_8c4d96:
	b L_8c033c
	.global L_8c4d9a
L_8c4d9a:
	mov_s r0,blink
L_8c4d9c:
	mov_s r2,0x1016254
L_8c4da2:
	mov_s r1,0x1438
L_8c4da8:
	bl.d L_8c82c0
L_8c4dac:
	mov_s r3,0x5d
L_8c4dae:
	b_s L_8c4d86
