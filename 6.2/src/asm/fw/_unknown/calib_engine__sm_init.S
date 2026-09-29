/* calib_engine__sm_init @ 0x8d8e5c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__init_all
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__bind_descriptor, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_engine__sm_init
calib_engine__sm_init:
	.global L_8d8e5c
L_8d8e5c:
	push_s blink
L_8d8e5e:
	bl L_8c01e0
L_8d8e62:
	mov.f r13,r2
L_8d8e66:
	mov_s r14,r0
L_8d8e68:
	mov_s r15,r1
L_8d8e6a:
	beq_s L_8d8e88
	.global L_8d8e6c
L_8d8e6c:
	mov_s r1,0x802234
L_8d8e72:
	bl.d L_8d94e0
L_8d8e76:
	mov_s r0,r14
L_8d8e78:
	st_s r15,[r14,0xc]
L_8d8e7a:
	st_s r13,[r14,0x8]
L_8d8e7c:
	ld_s r0,[r13,0x24]
L_8d8e7e:
	ld_s r1,[r0,0x4]
L_8d8e80:
	jl_s.d [r1]
L_8d8e82:
	mov_s r0,r13
L_8d8e84:
	b L_8c024c
	.global L_8d8e88
L_8d8e88:
	mov_s r0,blink
L_8d8e8a:
	mov_s r1,0x127d
L_8d8e90:
	bl L_8c9b28
L_8d8e94:
	b_s L_8d8e6c
L_8d8e96:
	nop_s
