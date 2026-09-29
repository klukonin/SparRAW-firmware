/* calib_lo_leakage__prepare_ctx @ 0x8f8f9c, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_leakage__sweep
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_lo_leakage__prepare_ctx
calib_lo_leakage__prepare_ctx:
	.global L_8f8f9c
L_8f8f9c:
	sub_s sp,sp,0x8
L_8f8f9e:
	push_s blink
L_8f8fa0:
	bl L_8c01e0
L_8f8fa4:
	mov_s r13,r4
L_8f8fa6:
	mul64_s r3,r13
L_8f8fa8:
	st_s r3,[r0,0x28]
L_8f8faa:
	st_s r1,[r0,0x10]
L_8f8fac:
	st_s r2,[r0,0x14]
L_8f8fae:
	sub r14,r1,mlo
L_8f8fb2:
	ld_s r15,[r0]
L_8f8fb4:
	add r13,mlo,r1
L_8f8fb8:
	st_s r14,[r0,0x18]
L_8f8fba:
	brge.d r14,r15,L_8f8fce
L_8f8fbe:
	st_s r13,[r0,0x1c]
L_8f8fc0:
	sub_s r15,r15,r14
L_8f8fc2:
	add_s r14,r14,r15
L_8f8fc4:
	st_s r14,[r0,0x18]
L_8f8fc6:
	add_s r13,r13,r15
L_8f8fc8:
	st_s r13,[r0,0x1c]
L_8f8fca:
	add_s r1,r1,r15
L_8f8fcc:
	st_s r1,[r0,0x10]
	.global L_8f8fce
L_8f8fce:
	ld_s r15,[r0,0x4]
L_8f8fd0:
	brge r15,r13,L_8f8fe6
L_8f8fd4:
	sub r1,r13,r15
L_8f8fd8:
	sub_s r14,r14,r1
L_8f8fda:
	sub_s r13,r13,r1
L_8f8fdc:
	st_s r13,[r0,0x1c]
L_8f8fde:
	ld_s r13,[r0,0x10]
L_8f8fe0:
	st_s r14,[r0,0x18]
L_8f8fe2:
	sub_s r13,r13,r1
L_8f8fe4:
	st_s r13,[r0,0x10]
	.global L_8f8fe6
L_8f8fe6:
	mov_s r1,r5
L_8f8fe8:
	mul64_s r3,r1
L_8f8fea:
	sub r1,r2,mlo
L_8f8fee:
	ld_s r3,[r0,0x8]
L_8f8ff0:
	add_s r2,r2,mlo
L_8f8ff2:
	st_s r1,[r0,0x20]
L_8f8ff4:
	brge.d r1,r3,L_8f900a
L_8f8ff8:
	st_s r2,[r0,0x24]
L_8f8ffa:
	sub_s r3,r3,r1
L_8f8ffc:
	add_s r1,r1,r3
L_8f8ffe:
	st_s r1,[r0,0x20]
L_8f9000:
	add_s r2,r2,r3
L_8f9002:
	ld_s r13,[r0,0x14]
L_8f9004:
	st_s r2,[r0,0x24]
L_8f9006:
	add_s r3,r3,r13
L_8f9008:
	st_s r3,[r0,0x14]
	.global L_8f900a
L_8f900a:
	ld_s r13,[r0,0xc]
L_8f900c:
	brge r13,r2,L_8f9022
L_8f9010:
	sub r3,r2,r13
L_8f9014:
	sub_s r1,r1,r3
L_8f9016:
	st_s r1,[r0,0x20]
L_8f9018:
	sub_s r2,r2,r3
L_8f901a:
	ld_s r1,[r0,0x14]
L_8f901c:
	st_s r2,[r0,0x24]
L_8f901e:
	sub_s r1,r1,r3
L_8f9020:
	st_s r1,[r0,0x14]
	.global L_8f9022
L_8f9022:
	mov_s r12,0xc
L_8f9024:
	b L_8c024e
