/* calib_mngr__cancel_scheme_step @ 0x8c5b48, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_mngr.cpp
 * Зовут его: calib_mngr__cancel_all_schemes
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, u_schd__cancel
 */
	.section .text.calib_mngr__cancel_scheme_step,"ax",@progbits
	.global calib_mngr__cancel_scheme_step
calib_mngr__cancel_scheme_step:
	.global L_8c5b48
L_8c5b48:
	push_s blink
L_8c5b4a:
	bl L_8c02c0
L_8c5b4e:
	brhs.d r0,0x6,L_8c5b70
L_8c5b52:
	mov_s r13,r0
	.global L_8c5b54
L_8c5b54:
	mov_s r15,0x842840
L_8c5b5a:
	add_s r12,r15,r13
L_8c5b5c:
	add2_s r15,r15,r13
L_8c5b5e:
	ld_s r0,[r15,0x8]
L_8c5b60:
	mov_s r14,0x0
L_8c5b62:
	stb_s r14,[r12]
L_8c5b64:
	breq_s r0,0,L_8c5b6c
L_8c5b66:
	bl L_8c7794
L_8c5b6a:
	st_s r14,[r15,0x8]
	.global L_8c5b6c
L_8c5b6c:
	b L_8c032c
	.global L_8c5b70
L_8c5b70:
	mov_s r0,blink
L_8c5b72:
	mov_s r2,0x10085d4
L_8c5b78:
	mov_s r1,0x1214
L_8c5b7e:
	bl.d L_8c82c0
L_8c5b82:
	mov r3,0x1b1
L_8c5b86:
	b_s L_8c5b54
