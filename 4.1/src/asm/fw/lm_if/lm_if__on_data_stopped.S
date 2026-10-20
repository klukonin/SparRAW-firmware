/* lm_if__on_data_stopped @ 0x8e2f2c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_if.cpp
 * Зовут его: disc_sm__sw_data_stopped
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_sysassert_fatal, u_schd__cancel
 */
	.section .text.lm_if__on_data_stopped,"ax",@progbits
	.global lm_if__on_data_stopped
lm_if__on_data_stopped:
	.global L_8e2f2c
L_8e2f2c:
	push_s blink
L_8e2f2e:
	bl L_8c02c4
L_8e2f32:
	mov_s r13,r0
L_8e2f34:
	ld_s r0,[r0]
L_8e2f36:
	breq_s r0,0,L_8e2f58
	.global L_8e2f38
L_8e2f38:
	ld_s r0,[r13,0x40]
L_8e2f3a:
	mov_s r14,0x0
L_8e2f3c:
	breq_s r0,0,L_8e2f44
L_8e2f3e:
	bl L_8c7794
L_8e2f42:
	st_s r14,[r13,0x40]
	.global L_8e2f44
L_8e2f44:
	st_s r14,[r13,0x44]
L_8e2f46:
	ld_s r0,[r13]
L_8e2f48:
	mov_s r1,0x3
L_8e2f4a:
	mov_s r2,0x0
L_8e2f4c:
	mov_s r3,r2
L_8e2f4e:
	bl.d L_8d6a1c
L_8e2f52:
	mov_s r4,r2
L_8e2f54:
	b L_8c0334
	.global L_8e2f58
L_8e2f58:
	mov_s r0,blink
L_8e2f5a:
	mov_s r2,0x1010e10
L_8e2f60:
	mov_s r1,0x1261
L_8e2f66:
	bl.d L_8c82c0
L_8e2f6a:
	mov_s r3,0x97
L_8e2f6c:
	b_s L_8e2f38
L_8e2f6e:
	nop_s
