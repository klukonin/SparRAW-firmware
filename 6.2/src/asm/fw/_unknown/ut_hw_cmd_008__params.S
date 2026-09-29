/* ut_hw_cmd_008__params @ 0x8e6f94, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ut_hw_cmd_0x008
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ba_sm__addba_at_10, bits__set32_s24_w2, qh__write_or_conn_alloc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_cmd_008__params
ut_hw_cmd_008__params:
	.global L_8e6f94
L_8e6f94:
	push_s blink
L_8e6f96:
	bl.d L_8c01e0
L_8e6f9a:
	mov_s r5,r1
L_8e6f9c:
	sub_s sp,sp,0x70
L_8e6f9e:
	mov_s r13,r0
L_8e6fa0:
	mov_s r15,r2
L_8e6fa2:
	ldw_s r3,[r0,0xe]
L_8e6fa4:
	mov_s r14,sp
L_8e6fa6:
	ldb r4,[r0, 0xf]
L_8e6faa:
	lsr_s r3,r3
L_8e6fac:
	ldb_s r2,[r0,0xd]
L_8e6fae:
	mov_s r1,r14
L_8e6fb0:
	bl.d L_8c7edc
L_8e6fb4:
	bmsk_s r3,r3,0x0
L_8e6fb6:
	bmsk r1,r15,0x1
L_8e6fba:
	add_s r0,sp,0x10
L_8e6fbc:
	bl.d L_8ed460
L_8e6fc0:
	mov_s r2,r14
L_8e6fc2:
	ldb_s r0,[r13,0xa]
L_8e6fc4:
	mov_s r1,0x2
L_8e6fc6:
	bl.d L_8ea5b0
L_8e6fca:
	mov_s r3,0x0
L_8e6fcc:
	b.d L_8c024c
L_8e6fd0:
	add_s sp,sp,0x70
L_8e6fd2:
	nop_s
