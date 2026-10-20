/* mac_mem__addr_of_slot @ 0x928e68, 272 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: macq__kick_queue_tx
 * Зовёт сам: macq_hw__set_ctrl_bit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_mem__addr_of_slot
mac_mem__addr_of_slot:
	.global L_928e68
L_928e68:
	st.a r13,[sp,-0xc]
L_928e6c:
	st blink,[sp, 0x4]
L_928e70:
	st_s r14,[sp,0x8]
L_928e72:
	mov_s r14,r0
L_928e74:
	mov r5,r1
L_928e78:
	bl.d L_928e38
L_928e7c:
	mov r13,r2
L_928e80:
	asl r4,r14,0x3
L_928e84:
	sub r4,r4,r14
L_928e88:
	asl r4,r4,0x7
L_928e8c:
	add r1,r4,0x4409980
L_928e94:
	lsr_s r1,r1,0x3
L_928e96:
	bic r1,r1,0x3
L_928e9a:
	st r5,[r1]
L_928e9e:
	add r2,r4,0x44099c0
L_928ea6:
	lsr r9,r2,0x3
L_928eaa:
	bic r0,r9,0x3
L_928eae:
	ld r8,[r0]
L_928eb2:
	bmsk_s r2,r2,0x4
L_928eb4:
	asl r7,0x1,r2
L_928ebc:
	bic r8,r8,r7
L_928ec0:
	or r7,r7,r8
L_928ec4:
	st r7,[r0]
L_928ec8:
	asl r3,r13,0x10
L_928ecc:
	and r3,r3,0x1f0000
L_928ed4:
	or r2,r3,0xf
L_928ed8:
	add r4,r4,0x44096c0
L_928ee0:
	lsr r4,r4,0x3
L_928ee4:
	st r2,[r4]
L_928ee8:
	sync
L_928eec:
	nop_s
L_928eee:
	nop_s
L_928ef0:
	mov 0x0,0x0
L_928ef4:
	asl r5,r14,0x3
L_928ef8:
	sub r5,r5,r14
L_928efc:
	asl r5,r5,0x7
L_928f00:
	add r5,r5,0x4409700
L_928f08:
	lsr r5,r5,0x3
L_928f0c:
	mov r10,0x1
L_928f10:
	st r10,[r5]
L_928f14:
	sync
L_928f18:
	nop_s
L_928f1a:
	nop_s
L_928f1c:
	nop_s
L_928f1e:
	asl_s r0,r14,0x3
L_928f20:
	sub_s r0,r0,r14
L_928f22:
	/* asl_s r0,r0,0x7 */
	.byte 0x07,0xb8
L_928f24:
	add_s r0,r0,0x4409700
L_928f2a:
	lsr_s r0,r0,0x3
L_928f2c:
	mov r11,0x0
L_928f30:
	st r11,[r0]
L_928f34:
	sync
L_928f38:
	nop_s
L_928f3a:
	nop_s
L_928f3c:
	nop_s
L_928f3e:
	asl_s r13,r13,0x10
L_928f40:
	and r13,r13,0x1f0000
L_928f48:
	or r1,r13,0x1f
L_928f4c:
	asl r6,r14,0x3
L_928f50:
	sub r6,r6,r14
L_928f54:
	asl r6,r6,0x7
L_928f58:
	add r6,r6,0x44096c0
L_928f60:
	lsr r6,r6,0x3
L_928f64:
	st r1,[r6]
L_928f68:
	sync
L_928f6c:
	ld blink,[sp, 0x4]
L_928f70:
	ld_s r14,[sp,0x8]
L_928f72:
	j_s.d [blink]
L_928f74:
	ld.ab r13,[sp,0xc]
