/* rm_main_sm__secondary_tune_done @ 0x8e4f18, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::secondary_tune_done. channelID=%d, rx_on=%d
 *   rm_main_sm::secondary_tune_done. callback is called for Handle:0x%x
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, rm__store_tune_request, sm__defer_call, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__secondary_tune_done
rm_main_sm__secondary_tune_done:
	.global L_8e4f18
L_8e4f18:
	push_s blink
L_8e4f1a:
	bl L_8c01d8
L_8e4f1e:
	mov_s r13,r0
L_8e4f20:
	ldb_s r0,[r0,0x3]
L_8e4f22:
	mov_s r15,r2
L_8e4f24:
	mov_s r16,r1
L_8e4f26:
	mov_s r17,r3
L_8e4f28:
	breq_s r0,0,L_8e4f3a
L_8e4f2a:
	mov_s r1,0x10190c4
L_8e4f30:
	mov_s r0,0x28
L_8e4f32:
	mov_s r2,r16
L_8e4f34:
	bl.d L_8dcc80
L_8e4f38:
	mov_s r3,r15
	.global L_8e4f3a
L_8e4f3a:
	mov_s r0,r13
L_8e4f3c:
	mov_s r1,r15
L_8e4f3e:
	mov_s r2,r16
L_8e4f40:
	bl.d L_8e9ab4
L_8e4f44:
	mov_s r3,r17
L_8e4f46:
	ld r14,[r13, 0x80]
L_8e4f4a:
	breq_s r14,0,L_8e4f88
	.global L_8e4f4c
L_8e4f4c:
	ld_s r0,[r14,0x8]
L_8e4f4e:
	breq r0,0x4,L_8e4fb2
L_8e4f52:
	ld_s r0,[r14,0x1c]
L_8e4f54:
	brne r15,r0,L_8e4f96
	.global L_8e4f58
L_8e4f58:
	breq_s r15,0,L_8e4f60
L_8e4f5a:
	ld_s r0,[r14,0x18]
L_8e4f5c:
	brne r0,r16,L_8e4fa4
	.global L_8e4f60
L_8e4f60:
	mov_s r0,0x3
L_8e4f62:
	st_s r0,[r14,0x8]
L_8e4f64:
	ldb_s r0,[r13,0x3]
L_8e4f66:
	breq_s r0,0,L_8e4f76
L_8e4f68:
	mov_s r1,0x10190fc
L_8e4f6e:
	mov_s r0,0x28
L_8e4f70:
	bl.d L_8dcc10
L_8e4f74:
	mov_s r2,r14
	.global L_8e4f76
L_8e4f76:
	mov_s r0,0x246e8
L_8e4f7c:
	mov_s r1,r14
L_8e4f7e:
	mov_s r2,0x0
L_8e4f80:
	bl.d L_8c3248
L_8e4f84:
	mov_s r3,0x1
L_8e4f86:
	b_s L_8e4fc0
	.global L_8e4f88
L_8e4f88:
	mov_s r0,blink
L_8e4f8a:
	mov_s r1,0x1172
L_8e4f90:
	bl L_8c9b28
L_8e4f94:
	b_s L_8e4f4c
	.global L_8e4f96
L_8e4f96:
	mov_s r0,blink
L_8e4f98:
	mov_s r1,0x1173
L_8e4f9e:
	bl L_8c9b28
L_8e4fa2:
	b_s L_8e4f58
	.global L_8e4fa4
L_8e4fa4:
	mov_s r0,blink
L_8e4fa6:
	mov_s r1,0x1174
L_8e4fac:
	bl L_8c9b28
L_8e4fb0:
	b_s L_8e4f60
	.global L_8e4fb2
L_8e4fb2:
	mov_s r0,r13
L_8e4fb4:
	mov_s r1,0x7
L_8e4fb6:
	mov_s r2,r14
L_8e4fb8:
	mov_s r3,0x0
L_8e4fba:
	bl.d L_8e7044
L_8e4fbe:
	mov_s r4,r3
	.global L_8e4fc0
L_8e4fc0:
	b L_8c023c
