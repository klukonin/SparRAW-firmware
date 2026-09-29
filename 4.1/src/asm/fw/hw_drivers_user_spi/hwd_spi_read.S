/* hwd_spi_read @ 0x8f0ee0, 376 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SPI READ: waited %d usec for interface !!!
 *   SPI LOCK FAILED (GUI_LOCK_CNT=%d GUI_UNLOCK_CNT=%d)
 *   SPI LOCK FAILED (FW last locked)
 *   SPI LOCK FAILED (FW last released)
 *   SPI LOCK FAILED (owner 0x%X)
 *   hw_drivers_user_spi.c
 * Зовут его: lo_power_gc_ctrl
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_sysassert_fatal, hwd_spi__poll_done, set_reg_8801a8_x2, sys__assert_no_error
 */
	.section .text.hwd_spi_read,"ax",@progbits
	.global hwd_spi_read
hwd_spi_read:
	.global L_8f0ee0
L_8f0ee0:
	push_s blink
L_8f0ee2:
	bl L_8c02b8
L_8f0ee6:
	sub_s sp,sp,0x4
L_8f0ee8:
	mov_s r17,r0
L_8f0eea:
	mov_s r15,r1
L_8f0eec:
	mov_s r16,r2
L_8f0eee:
	mov_s r0,0x4c4b40
L_8f0ef4:
	bl.d L_8f0e94
L_8f0ef8:
	mov_s r13,0x64
L_8f0efa:
	cmp_s r0,0x0
L_8f0efc:
	beq_s L_8f0fc4
L_8f0efe:
	mov lp_count,0x65
L_8f0f02:
	nop_s
L_8f0f04:
	lp L_8f0f36
L_8f0f08:
	mov_s r0,0x50
L_8f0f0a:
	mov lp_count,r0
L_8f0f0e:
	nop_s
L_8f0f10:
	lp L_8f0f18
L_8f0f14:
	nop_s
L_8f0f16:
	nop_s
	.global L_8f0f18
L_8f0f18:
	mov_s r14,0x880180
L_8f0f1e:
	ld_s r0,[r14,0x28]
L_8f0f20:
	and r0,r0,0x20000000
L_8f0f28:
	cmp_s r0,0x0
L_8f0f2a:
	mov_s r0,0x1
L_8f0f2c:
	sub_s.ne r0,r0,r0
L_8f0f2e:
	extb.f 0x0,r0
L_8f0f32:
	bne_s L_8f0f36
L_8f0f34:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
	.global L_8f0f36
L_8f0f36:
	cmp_s r13,0x64
L_8f0f38:
	beq_s L_8f0f4e
L_8f0f3a:
	mov_s r2,0x1019798
L_8f0f40:
	mov_s r12,0x64
L_8f0f42:
	rsub r3,r13,r12
L_8f0f46:
	mov_s r0,0x0
L_8f0f48:
	bl.d L_8edfcc
L_8f0f4c:
	mov_s r1,0x1
	.global L_8f0f4e
L_8f0f4e:
	ld_s r0,[r14,0x28]
L_8f0f50:
	bbit1 r0,0x1d,L_8f1030
	.global L_8f0f54
L_8f0f54:
	brlo 0x100,r15,L_8f1044
	.global L_8f0f5c
L_8f0f5c:
	st r17,[r14, 0x30]
L_8f0f60:
	or r0,r15,0x3030000
L_8f0f68:
	st_s r0,[r14,0x2c]
L_8f0f6a:
	st 0xc0000000,[r14, 0x28]
	.global L_8f0f72
L_8f0f72:
	ld_s r0,[r14,0x28]
L_8f0f74:
	bbit1 r0,0x1d,L_8f0f72
L_8f0f78:
	asr_s r0,r15,0x2
L_8f0f7a:
	mov_s r2,0x0
L_8f0f7c:
	mov_s r3,0x8800a8
L_8f0f82:
	cmp_s r0,0x0
L_8f0f84:
	mov_s r1,r3
L_8f0f86:
	mov.hi lp_count,r0
L_8f0f8a:
	lphi L_8f0f9c
L_8f0f8e:
	ld_s r0,[r1]
L_8f0f90:
	add2 r12,r16,r2
L_8f0f94:
	st_s r0,[r12]
L_8f0f96:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8f0f98:
	add2 r1,r3,r2
	.global L_8f0f9c
L_8f0f9c:
	ld_s r1,[r1]
L_8f0f9e:
	add2 r0,r16,r2
L_8f0fa2:
	st_s r1,[sp,0x0]
L_8f0fa4:
	bmsk_s r15,r15,0x1
L_8f0fa6:
	mov_s r1,0x0
L_8f0fa8:
	cmp_s r15,0x0
L_8f0faa:
	mov.hi lp_count,r15
L_8f0fae:
	lphi L_8f0fbc
L_8f0fb2:
	ldb r2,[sp,r1]
L_8f0fb6:
	add_s r12,r0,r1
L_8f0fb8:
	stb_s r2,[r12]
L_8f0fba:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8f0fbc
L_8f0fbc:
	bl L_8f1058
L_8f0fc0:
	mov_s r0,0x1
L_8f0fc2:
	b_s L_8f102a
	.global L_8f0fc4
L_8f0fc4:
	mov_s r2,0x10197c4
L_8f0fca:
	mov_s r13,0x880a3c
L_8f0fd0:
	ld r4,[r13, 0x40]
L_8f0fd4:
	mov_s r0,0x0
L_8f0fd6:
	mov_s r1,r0
L_8f0fd8:
	bl.d L_8edff8
L_8f0fdc:
	ld_s r3,[r13,0x3c]
L_8f0fde:
	ld_s r3,[r13,0x4c]
L_8f0fe0:
	brne r3,0x1234,L_8f0ff8
L_8f0fe8:
	mov_s r2,0x10197f8
	.global L_8f0fee
L_8f0fee:
	mov_s r0,0x0
L_8f0ff0:
	bl.d L_8edfb0
L_8f0ff4:
	mov_s r1,r0
L_8f0ff6:
	b_s L_8f1016
	.global L_8f0ff8
L_8f0ff8:
	brne r3,0x4321,L_8f1008
L_8f1000:
	mov_s r2,0x101981c
L_8f1006:
	b_s L_8f0fee
	.global L_8f1008
L_8f1008:
	mov_s r2,0x1019840
L_8f100e:
	mov_s r0,0x0
L_8f1010:
	bl.d L_8edfcc
L_8f1014:
	mov_s r1,r0
	.global L_8f1016
L_8f1016:
	mov_s r0,blink
L_8f1018:
	mov_s r2,0x1019860
L_8f101e:
	mov_s r1,0x15
L_8f1020:
	bset_s r1,r1,0xc
L_8f1022:
	bl.d L_8c8208
L_8f1026:
	mov_s r3,0x5b
L_8f1028:
	mov_s r0,0x0
	.global L_8f102a
L_8f102a:
	b.d L_8c031c
L_8f102e:
	add_s sp,sp,0x4
	.global L_8f1030
L_8f1030:
	mov_s r0,blink
L_8f1032:
	mov_s r2,0x1019860
L_8f1038:
	mov_s r1,0x1e
L_8f103a:
	bset_s r1,r1,0xc
L_8f103c:
	bl.d L_8c82c0
L_8f1040:
	mov_s r3,0x67
L_8f1042:
	b_s L_8f0f54
	.global L_8f1044
L_8f1044:
	mov_s r0,blink
L_8f1046:
	mov_s r2,0x1019860
L_8f104c:
	mov_s r1,0xea
L_8f104e:
	bset_s r1,r1,0xc
L_8f1050:
	bl.d L_8c82c0
L_8f1054:
	mov_s r3,0x6b
L_8f1056:
	b_s L_8f0f5c
