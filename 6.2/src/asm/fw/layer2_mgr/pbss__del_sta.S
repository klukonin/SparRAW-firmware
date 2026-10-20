/* pbss__del_sta @ 0x8e01f4, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEL PBSS AID %d, MAC address ADDR-%04X%08X
 *   DIRECT LINK LOST NTF -> DISCONNECT from CID: %d. AID: %d
 * Зовут его: pbss_sta_list_update
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn__disconnect, fw_log_emit2, fw_log_emit3, pbss__cid_by_aid, pbss__free_sta_slot
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pbss__del_sta
pbss__del_sta:
	.global L_8e01f4
L_8e01f4:
	push_s blink
L_8e01f6:
	bl L_8c01e0
L_8e01fa:
	mov.f r14,r1
L_8e01fe:
	mov_s r13,r0
L_8e0200:
	beq_s L_8e0268
L_8e0202:
	ldb_s r0,[r14,0x5]
L_8e0204:
	ldb_s r3,[r14,0x4]
L_8e0206:
	asl_s r0,r0,0x8
L_8e0208:
	or_s r3,r3,r0
L_8e020a:
	ldb_s r0,[r14,0x1]
L_8e020c:
	ldb r4,[r14]
L_8e0210:
	asl_s r0,r0,0x8
L_8e0212:
	or r4,r4,r0
L_8e0216:
	ldb_s r0,[r14,0x2]
L_8e0218:
	mov_s r1,0x100f8d0
L_8e021e:
	asl_s r0,r0,0x10
L_8e0220:
	or r4,r4,r0
L_8e0224:
	ldb_s r0,[r14,0x3]
L_8e0226:
	asl_s r0,r0,0x18
L_8e0228:
	or r4,r4,r0
L_8e022c:
	mov_s r0,0x2b
L_8e022e:
	bl.d L_8dcd00
L_8e0232:
	ldb_s r2,[r14,0x6]
L_8e0234:
	ld_s r15,[r13,0x18]
L_8e0236:
	mov_s r0,r15
L_8e0238:
	bl.d L_8cbf64
L_8e023c:
	ldb_s r1,[r14,0x6]
L_8e023e:
	mov.f r13,r0
L_8e0242:
	beq_s L_8e0268
L_8e0244:
	ldb_s r2,[r13,0x8]
L_8e0246:
	mov_s r1,0x100f8fc
L_8e024c:
	mov_s r0,0x2b
L_8e024e:
	bl.d L_8dcc80
L_8e0252:
	ldb_s r3,[r13,0x9]
L_8e0254:
	mov_s r0,r13
L_8e0256:
	mov_s r1,0xb
L_8e0258:
	bl.d L_8f2540
L_8e025c:
	mov_s r2,0x1
L_8e025e:
	add3 r0,r15,0x9
L_8e0262:
	bl.d L_8c8c04
L_8e0266:
	ldb_s r1,[r14,0x6]
	.global L_8e0268
L_8e0268:
	b L_8c024c
