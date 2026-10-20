/* sched__build_alloc_entry @ 0x8c2ca4, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: schedule_scheme_builder__build_allocations
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bits__set32_s0_w4, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sched__build_alloc_entry
sched__build_alloc_entry:
	.global L_8c2ca4
L_8c2ca4:
	push_s blink
L_8c2ca6:
	bl L_8c01dc
L_8c2caa:
	sub_s sp,sp,0x10
L_8c2cac:
	mov_s r14,r1
L_8c2cae:
	mov_s r15,r2
L_8c2cb0:
	mov_s r13,r3
L_8c2cb2:
	mov r16,r4
L_8c2cb6:
	mov_s r0,sp
L_8c2cb8:
	mov_s r1,0x805250
L_8c2cbe:
	bl.d L_8c0380
L_8c2cc2:
	mov_s r2,0xf
L_8c2cc4:
	bmsk r1,r15,0x3
L_8c2cc8:
	mov_s r0,sp
L_8c2cca:
	bl.d L_8ed370
L_8c2cce:
	mov_s r2,0xf
L_8c2cd0:
	ldb_s r0,[r13,0xe]
L_8c2cd2:
	stb_s r0,[sp,0x4]
L_8c2cd4:
	ldb_s r0,[r13,0xf]
L_8c2cd6:
	stw r14,[sp, 0x6]
L_8c2cda:
	lsr_s r14,r14,0x10
L_8c2cdc:
	stb r0,[sp, 0x5]
L_8c2ce0:
	stw r14,[sp, 0x8]
L_8c2ce4:
	ldw_s r0,[r13,0x6]
L_8c2ce6:
	stw r0,[sp, 0xa]
L_8c2cea:
	mov_s r0,r16
L_8c2cec:
	bl.d L_8c0380
L_8c2cf0:
	mov_s r1,sp
L_8c2cf2:
	b.d L_8c0244
L_8c2cf6:
	add_s sp,sp,0x10
