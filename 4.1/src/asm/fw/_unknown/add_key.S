/* add_key @ 0x8ce17c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   In the add_key function. KEY[0]ADDRESS: %x
 * Зовут его: key__install_by_type
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, memcpy_fw
 */
	.section .text.add_key,"ax",@progbits
	.global add_key
add_key:
	.global L_8ce17c
L_8ce17c:
	push_s blink
L_8ce17e:
	bl.d L_8c02c4
L_8ce182:
	mov_s r2,r0
L_8ce184:
	sub_s sp,sp,0x10
L_8ce186:
	mov_s r13,r1
L_8ce188:
	mov_s r0,sp
L_8ce18a:
	mov_s r1,r2
L_8ce18c:
	bl.d L_8c0460
L_8ce190:
	mov_s r2,0x10
L_8ce192:
	ld_s r0,[sp,0x0]
L_8ce194:
	mov_s r14,0x886000
L_8ce19a:
	st_s r0,[r14,0x38]
L_8ce19c:
	ld_s r0,[sp,0x4]
L_8ce19e:
	mov_s r2,0x1019e70
L_8ce1a4:
	st_s r0,[r14,0x3c]
L_8ce1a6:
	ld_s r0,[sp,0x8]
L_8ce1a8:
	mov_s r1,0x2
L_8ce1aa:
	st_s r0,[r14,0x40]
L_8ce1ac:
	ld_s r0,[sp,0xc]
L_8ce1ae:
	st_s r0,[r14,0x44]
L_8ce1b0:
	st_s r13,[r14,0x34]
L_8ce1b2:
	mov_s r0,0x0
L_8ce1b4:
	st 0x80000000,[r14, 0x30]
L_8ce1bc:
	st 0x40000000,[r14, 0x2c]
L_8ce1c4:
	bl.d L_8edfcc
L_8ce1c8:
	mov_s r3,r13
L_8ce1ca:
	mov_s r1,0x0
L_8ce1cc:
	ld r0,[r14, 0xd8]
L_8ce1d0:
	bset r1,r1,r13
L_8ce1d4:
	bic_s r0,r0,r1
L_8ce1d6:
	or_s r0,r0,r1
L_8ce1d8:
	st r0,[r14, 0xd8]
L_8ce1dc:
	b.d L_8c0334
L_8ce1e0:
	add_s sp,sp,0x10
L_8ce1e2:
	nop_s
