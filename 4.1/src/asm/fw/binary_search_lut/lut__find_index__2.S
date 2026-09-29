/* lut__find_index__2 @ 0x8c8ca0, 296 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lut::find_index(): x=%d out of search range [%d,%d]
 *   lut::find_index(): start_idx=%d, end_idx=%d
 *   binary_search_lut.cpp
 *   lut::find_index(): bad middle_idx=0, end_idx=%d, start_idx=%d, x=%d
 *   lut::find_index(): Binary search hasn't converged after %d iterations. lut_size=%d
 * Зовут его: lut__find_index
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.lut__find_index__2,"ax",@progbits
	.global lut__find_index__2
lut__find_index__2:
	.global L_8c8ca0
L_8c8ca0:
	push_s blink
L_8c8ca2:
	bl L_8c02b0
L_8c8ca6:
	mov_s r16,r0
L_8c8ca8:
	mov_s r18,r1
L_8c8caa:
	mov_s r14,0x0
L_8c8cac:
	ld r1,[r16]
L_8c8cb0:
	ld_s r0,[r0,0x8]
L_8c8cb2:
	ld.as r2,[r1,r14]
L_8c8cb6:
	brlt.d r2,r18,L_8c8cc0
L_8c8cba:
	sub_s r13,r0,0x1
	.global L_8c8cbc
L_8c8cbc:
	mov_s r13,r14
L_8c8cbe:
	b_s L_8c8dba
	.global L_8c8cc0
L_8c8cc0:
	ld.as r2,[r1,r13]
L_8c8cc4:
	cmp_s r2,r18
L_8c8cc6:
	ble L_8c8dba
L_8c8cca:
	add2 r17,r0,r0
L_8c8cce:
	mov_s r15,r14
L_8c8cd0:
	b_s L_8c8dc0
	.global L_8c8cd2
L_8c8cd2:
	ld.as r4,[r1,r14]
L_8c8cd6:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8c8cd8:
	brlt.d r18,r4,L_8c8ce4
L_8c8cdc:
	ld.as r5,[r1,r19]
L_8c8ce0:
	brge r5,r18,L_8c8d1c
	.global L_8c8ce4
L_8c8ce4:
	mov_s r2,0x1006f34
L_8c8cea:
	mov_s r0,0x0
L_8c8cec:
	mov_s r1,r0
L_8c8cee:
	bl.d L_8ee034
L_8c8cf2:
	mov_s r3,r18
L_8c8cf4:
	mov_s r2,0x1006f68
L_8c8cfa:
	mov_s r0,0x0
L_8c8cfc:
	mov_s r1,r0
L_8c8cfe:
	mov_s r3,r14
L_8c8d00:
	bl.d L_8edff8
L_8c8d04:
	mov r4,r19
L_8c8d08:
	mov_s r0,blink
L_8c8d0a:
	mov_s r2,0x1006f1c
L_8c8d10:
	mov_s r1,0x1443
L_8c8d16:
	bl.d L_8c82c0
L_8c8d1a:
	mov_s r3,0x49
	.global L_8c8d1c
L_8c8d1c:
	sub r0,r19,r14
L_8c8d20:
	brlo r0,0x2,L_8c8d9c
L_8c8d24:
	add r13,r19,r14
L_8c8d28:
	lsr.f r13,r13
L_8c8d2c:
	bne_s L_8c8d5a
L_8c8d2e:
	mov_s r2,0x1006f94
L_8c8d34:
	mov_s r0,0x0
L_8c8d36:
	mov_s r1,r0
L_8c8d38:
	mov_s r3,r14
L_8c8d3a:
	mov r4,r19
L_8c8d3e:
	bl.d L_8ee034
L_8c8d42:
	mov r5,r18
L_8c8d46:
	mov_s r0,blink
L_8c8d48:
	mov_s r2,0x1006f1c
L_8c8d4e:
	mov_s r1,0x1444
L_8c8d54:
	bl.d L_8c82c0
L_8c8d58:
	mov_s r3,0x57
	.global L_8c8d5a
L_8c8d5a:
	ld r1,[r16]
L_8c8d5e:
	ld.as r0,[r1,r13]
L_8c8d62:
	breq r0,r18,L_8c8dba
L_8c8d66:
	brlt r18,r0,L_8c8dc0
L_8c8d6a:
	brlt r0,r18,L_8c8dc4
	.global L_8c8d6e
L_8c8d6e:
	brlo r15,r17,L_8c8cd2
L_8c8d72:
	mov_s r2,0x1006fd8
L_8c8d78:
	ld r4,[r16, 0x8]
L_8c8d7c:
	mov_s r0,0x0
L_8c8d7e:
	mov_s r1,r0
L_8c8d80:
	bl.d L_8edff8
L_8c8d84:
	mov_s r3,r15
L_8c8d86:
	mov_s r0,blink
L_8c8d88:
	mov_s r2,0x1006f1c
L_8c8d8e:
	mov_s r1,0x1446
L_8c8d94:
	bl.d L_8c82c0
L_8c8d98:
	mov_s r3,0x68
L_8c8d9a:
	b_s L_8c8cbc
	.global L_8c8d9c
L_8c8d9c:
	ld r2,[r16]
L_8c8da0:
	ld.as r0,[r2,r14]
L_8c8da4:
	sub r1,r18,r0
L_8c8da8:
	ld.as r0,[r2,r19]
L_8c8dac:
	sub r0,r0,r18
L_8c8db0:
	cmp_s r1,r0
L_8c8db2:
	mov.lt r13,r14
L_8c8db6:
	mov.ge r13,r19
	.global L_8c8dba
L_8c8dba:
	b.d L_8c030c
L_8c8dbe:
	mov_s r0,r13
	.global L_8c8dc0
L_8c8dc0:
	mov_s r19,r13
L_8c8dc2:
	b_s L_8c8d6e
	.global L_8c8dc4
L_8c8dc4:
	mov_s r14,r13
L_8c8dc6:
	b_s L_8c8d6e
