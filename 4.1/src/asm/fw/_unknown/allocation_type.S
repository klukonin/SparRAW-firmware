/* allocation_type @ 0x8dcd68, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ESE CFG CMD. ESE: Allocation start TSF: %x, My AID: %d
 *   allocation_type: %x, pseudo_static: %x, source_aid: %x
 *   destination_aid: %x, allocation_block_duration: %x, number_of_blocks: %x
 * Зовут его: parse_ese
 * Зовёт сам: __ld_r13_ret, fw_log__emit2, fw_log__emit3
 */
	.section .text.allocation_type,"ax",@progbits
	.global allocation_type
allocation_type:
	.global L_8dcd68
L_8dcd68:
	push_s blink
L_8dcd6a:
	push_s r13
L_8dcd6c:
	ld_s r0,[r0]
L_8dcd6e:
	mov_s r13,r1
L_8dcd70:
	ldb r4,[r0, 0x8]
L_8dcd74:
	ldb_s r0,[r1,0x7]
L_8dcd76:
	ldb_s r3,[r1,0x6]
L_8dcd78:
	asl_s r0,r0,0x8
L_8dcd7a:
	or_s r3,r3,r0
L_8dcd7c:
	ldb_s r0,[r1,0x8]
L_8dcd7e:
	mov_s r2,0x101187c
L_8dcd84:
	asl_s r0,r0,0x10
L_8dcd86:
	or_s r3,r3,r0
L_8dcd88:
	ldb_s r0,[r1,0x9]
L_8dcd8a:
	asl_s r0,r0,0x18
L_8dcd8c:
	or_s r3,r3,r0
L_8dcd8e:
	mov_s r0,0xb
L_8dcd90:
	bl.d L_8edff8
L_8dcd94:
	mov_s r1,0x2
L_8dcd96:
	ldb_s r0,[r13]
L_8dcd98:
	mov_s r2,0x10118b4
L_8dcd9e:
	lsr r3,r0,0x4
L_8dcda2:
	lsr r4,r0,0x7
L_8dcda6:
	ldb r5,[r13, 0x4]
L_8dcdaa:
	mov_s r0,0xb
L_8dcdac:
	mov_s r1,0x2
L_8dcdae:
	bl.d L_8ee034
L_8dcdb2:
	bmsk_s r3,r3,0x2
L_8dcdb4:
	mov_s r2,0x10118ec
L_8dcdba:
	ldb_s r0,[r13,0xb]
L_8dcdbc:
	ldb r4,[r13, 0xa]
L_8dcdc0:
	asl_s r0,r0,0x8
L_8dcdc2:
	or r4,r4,r0
L_8dcdc6:
	ldb r5,[r13, 0xc]
L_8dcdca:
	mov_s r0,0xb
L_8dcdcc:
	mov_s r1,0x2
L_8dcdce:
	bl.d L_8ee034
L_8dcdd2:
	ldb_s r3,[r13,0x5]
L_8dcdd4:
	b L_8c033c
