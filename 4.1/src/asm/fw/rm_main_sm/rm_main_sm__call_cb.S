/* rm_main_sm__call_cb @ 0x8c4bc0, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::call_cb.[Handle:0x%x][CB:0x%x][Context:0x%x]
 *   rm_main_sm.cpp
 *   rm_main_sm::call_cb.[Handle:0x%x] CB 0x%x NOT called, state is %d
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.rm_main_sm__call_cb,"ax",@progbits
	.global rm_main_sm__call_cb
rm_main_sm__call_cb:
L_8c4bc0:
	push_s blink
L_8c4bc2:
	bl L_8c02c4
L_8c4bc6:
	ld r5,[r1, 0x8]
L_8c4bca:
	mov_s r14,r0
L_8c4bcc:
	mov_s r13,r1
L_8c4bce:
	brne r5,0x3,L_8c4c26
L_8c4bd2:
	ld_s r0,[r13,0x4]
L_8c4bd4:
	add2 r1,r14,0x31
L_8c4bd8:
	cmp_s r1,r0
L_8c4bda:
	mov_s r0,0x1
L_8c4bdc:
	sub_s.ne r0,r0,r0
L_8c4bde:
	extb.f 0x0,r0
L_8c4be2:
	beq_s L_8c4c0e
	.global L_8c4be4
L_8c4be4:
	ld_s r0,[r14,0x28]
L_8c4be6:
	ld r4,[r13, 0xc]
L_8c4bea:
	ld r5,[r13, 0x10]
L_8c4bee:
	mov_s r14,0x2
L_8c4bf0:
	breq_s r0,0,L_8c4c02
L_8c4bf2:
	mov_s r2,0x1016044
L_8c4bf8:
	mov_s r0,0x8
L_8c4bfa:
	mov_s r1,r14
L_8c4bfc:
	bl.d L_8ee034
L_8c4c00:
	mov_s r3,r13
	.global L_8c4c02
L_8c4c02:
	st_s r14,[r13,0x8]
L_8c4c04:
	ld_s r2,[r13,0xc]
L_8c4c06:
	mov_s r0,r13
L_8c4c08:
	jl_s.d [r2]
L_8c4c0a:
	ld_s r1,[r13,0x10]
L_8c4c0c:
	b_s L_8c4c3e
	.global L_8c4c0e
L_8c4c0e:
	mov_s r0,blink
L_8c4c10:
	mov_s r2,0x1015d54
L_8c4c16:
	mov_s r1,0x1178
L_8c4c1c:
	bl.d L_8c82c0
L_8c4c20:
	mov r3,0x23e
L_8c4c24:
	b_s L_8c4be4
	.global L_8c4c26
L_8c4c26:
	ld_s r0,[r14,0x28]
L_8c4c28:
	breq_s r0,0,L_8c4c3e
L_8c4c2a:
	mov_s r2,0x1016080
L_8c4c30:
	ld r4,[r13, 0xc]
L_8c4c34:
	mov_s r0,0x8
L_8c4c36:
	mov_s r1,0x2
L_8c4c38:
	bl.d L_8ee034
L_8c4c3c:
	mov_s r3,r13
	.global L_8c4c3e
L_8c4c3e:
	.byte 0xf9,0x06
