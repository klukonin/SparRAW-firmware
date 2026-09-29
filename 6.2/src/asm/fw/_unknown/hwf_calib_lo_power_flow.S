/* hwf_calib_lo_power_flow @ 0x8d5fa8, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_calib_lo_power_flow invalid parameters input
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, calib_lo_power__step, fw_log_emit0, memcpy_fw, rfc__pack_field_value, rfc__read_field_484
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_calib_lo_power_flow
hwf_calib_lo_power_flow:
	.global L_8d5fa8
L_8d5fa8:
	push_s blink
L_8d5faa:
	bl L_8c01c4
L_8d5fae:
	sub_s sp,sp,0x18
L_8d5fb0:
	mov.f r14,r0
L_8d5fb4:
	mov_s r16,r1
L_8d5fb6:
	mov_s r17,r2
L_8d5fb8:
	mov_s r21,r3
L_8d5fba:
	mov r20,r4
L_8d5fbe:
	mov r19,r5
L_8d5fc2:
	mov r18,r6
L_8d5fc6:
	cmp.ne r14,0x4
L_8d5fca:
	cmp.ne r14,0x5
L_8d5fce:
	cmp.ne r14,0x6
L_8d5fd2:
	cmp.ne r14,0x7
L_8d5fd6:
	bne_s L_8d5ffe
L_8d5fd8:
	cmp r16,0xe
L_8d5fdc:
	cmp.le r19,0xe
L_8d5fe0:
	bgt_s L_8d5ffe
L_8d5fe2:
	cmp r17,0x0
L_8d5fe6:
	cmp.ne r21,0x0
L_8d5fea:
	cmp.ne r20,0x0
L_8d5fee:
	beq_s L_8d5ffe
L_8d5ff0:
	cmp r17,0xf
L_8d5ff4:
	cmp.ls r21,0xf
L_8d5ff8:
	cmp.ls r20,0xf
L_8d5ffc:
	bls_s L_8d6010
	.global L_8d5ffe
L_8d5ffe:
	mov_s r1,0x101bd48
L_8d6004:
	mov_s r13,0x0
L_8d6006:
	bl.d L_8dcba8
L_8d600a:
	mov_s r0,r13
L_8d600c:
	mov_s r0,r13
L_8d600e:
	b_s L_8d605c
	.global L_8d6010
L_8d6010:
	mov_s r15,sp
L_8d6012:
	mov r22,0x803694
L_8d601a:
	mov_s r0,r15
L_8d601c:
	mov_s r1,r22
L_8d601e:
	bl.d L_8c0380
L_8d6022:
	mov_s r2,0xc
L_8d6024:
	add_s r13,sp,0xc
L_8d6026:
	mov_s r0,r13
L_8d6028:
	add r1,r22,0xc
L_8d602c:
	bl.d L_8c0380
L_8d6030:
	mov_s r2,0xc
L_8d6032:
	mov_s r0,r18
L_8d6034:
	bl.d L_8d32b0
L_8d6038:
	mov_s r1,r15
L_8d603a:
	mov_s r0,r18
L_8d603c:
	mov_s r1,r15
L_8d603e:
	mov_s r2,r13
L_8d6040:
	mov_s r3,r17
L_8d6042:
	mov r4,r21
L_8d6046:
	bl.d L_8d32e4
L_8d604a:
	mov r5,r20
L_8d604e:
	mov_s r0,r14
L_8d6050:
	mov_s r1,r16
L_8d6052:
	mov_s r2,r13
L_8d6054:
	bl.d L_8d5f78
L_8d6058:
	mov_s r3,r19
L_8d605a:
	mov_s r0,0x1
	.global L_8d605c
L_8d605c:
	b.d L_8c0214
L_8d6060:
	add_s sp,sp,0x18
L_8d6062:
	nop_s
