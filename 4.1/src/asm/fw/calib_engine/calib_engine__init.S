/* calib_engine__init @ 0x8d5cc4, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_engine.cpp
 * Зовут его: calib_mngr__init_schemes
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__setup, fw_sysassert_fatal
 */
	.section .text.calib_engine__init,"ax",@progbits
	.global calib_engine__init
calib_engine__init:
	.global L_8d5cc4
L_8d5cc4:
	push_s blink
L_8d5cc6:
	bl L_8c02bc
L_8d5cca:
	mov.f r13,r2
L_8d5cce:
	mov_s r14,r0
L_8d5cd0:
	mov_s r15,r1
L_8d5cd2:
	beq_s L_8d5d14
	.global L_8d5cd4
L_8d5cd4:
	mov r4,0x800db4
L_8d5cdc:
	mov r5,0x800dcc
L_8d5ce4:
	mov_s r0,r14
L_8d5ce6:
	ld.as r1,[gp,-0x8]
L_8d5cea:
	mov_s r2,0x0
L_8d5cec:
	mov_s r16,r2
L_8d5cee:
	mov_s r3,0x801d20
L_8d5cf4:
	mov r6,0x6
L_8d5cf8:
	bl.d L_8d6478
L_8d5cfc:
	mov r7,0x4
L_8d5d00:
	st r16,[r14, 0x28]
L_8d5d04:
	st_s r15,[r14,0x30]
L_8d5d06:
	st_s r13,[r14,0x2c]
L_8d5d08:
	ld_s r0,[r13,0x8]
L_8d5d0a:
	ld_s r1,[r0,0x4]
L_8d5d0c:
	jl_s.d [r1]
L_8d5d0e:
	mov_s r0,r13
L_8d5d10:
	b L_8c0324
	.global L_8d5d14
L_8d5d14:
	mov_s r0,blink
L_8d5d16:
	mov_s r2,0x1008a58
L_8d5d1c:
	mov_s r1,0x127d
L_8d5d22:
	bl.d L_8c82c0
L_8d5d26:
	mov_s r3,0x63
L_8d5d28:
	b_s L_8d5cd4
L_8d5d2a:
	nop_s
