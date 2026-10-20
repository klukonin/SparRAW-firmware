/* pbss__del_sta @ 0x8dc0f4, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEL PBSS AID %d, MAC address ADDR-%04X%08X
 *   DIRECT LINK LOST NTF -> DISCONNECT from CID: %d. AID: %d
 *   layer2_mgr.cpp
 * Зовут его: pbss_sta_list_update
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn__disconnect, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, pbss__cid_by_aid, pbss__free_sta_slot
 */
	.section .text.pbss__del_sta,"ax",@progbits
	.global pbss__del_sta
pbss__del_sta:
	.global L_8dc0f4
L_8dc0f4:
	push_s blink
L_8dc0f6:
	bl L_8c02c0
L_8dc0fa:
	mov.f r14,r1
L_8dc0fe:
	mov_s r13,r0
L_8dc100:
	beq_s L_8dc172
L_8dc102:
	ldb_s r0,[r14,0x5]
L_8dc104:
	ldb r4,[r14, 0x4]
L_8dc108:
	asl_s r0,r0,0x8
L_8dc10a:
	or r4,r4,r0
L_8dc10e:
	ldb_s r0,[r14,0x1]
L_8dc110:
	ldb r5,[r14]
L_8dc114:
	asl_s r0,r0,0x8
L_8dc116:
	or r5,r5,r0
L_8dc11a:
	ldb_s r0,[r14,0x2]
L_8dc11c:
	mov_s r2,0x100e1b4
L_8dc122:
	asl_s r0,r0,0x10
L_8dc124:
	or r5,r5,r0
L_8dc128:
	ldb_s r0,[r14,0x3]
L_8dc12a:
	mov_s r1,0x2
L_8dc12c:
	asl_s r0,r0,0x18
L_8dc12e:
	or r5,r5,r0
L_8dc132:
	mov_s r0,0xb
L_8dc134:
	bl.d L_8ee034
L_8dc138:
	ldb_s r3,[r14,0x6]
L_8dc13a:
	ld_s r15,[r13,0xc]
L_8dc13c:
	mov_s r0,r15
L_8dc13e:
	bl.d L_8c9da4
L_8dc142:
	ldb_s r1,[r14,0x6]
L_8dc144:
	mov.f r13,r0
L_8dc148:
	beq_s L_8dc176
	.global L_8dc14a
L_8dc14a:
	ldb r4,[r13, 0x9]
L_8dc14e:
	mov_s r2,0x100e1e0
L_8dc154:
	mov_s r0,0xb
L_8dc156:
	mov_s r1,0x2
L_8dc158:
	bl.d L_8edff8
L_8dc15c:
	ldb_s r3,[r13,0x8]
L_8dc15e:
	mov_s r0,r13
L_8dc160:
	mov_s r1,0xb
L_8dc162:
	bl.d L_8eb190
L_8dc166:
	mov_s r2,0x1
L_8dc168:
	add3 r0,r15,0x9
L_8dc16c:
	bl.d L_8c7594
L_8dc170:
	ldb_s r1,[r14,0x6]
	.global L_8dc172
L_8dc172:
	b L_8c032c
	.global L_8dc176
L_8dc176:
	mov_s r0,blink
L_8dc178:
	mov_s r2,0x100c474
L_8dc17e:
	mov_s r1,0x146f
L_8dc184:
	mov_s r3,0xa59
L_8dc18a:
	bl L_8c82c0
L_8dc18e:
	b_s L_8dc14a
