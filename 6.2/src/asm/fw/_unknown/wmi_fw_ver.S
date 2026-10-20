/* wmi_fw_ver @ 0x8dd130, 364 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_FW_VER_EVENTID
 *   FW version %d.%d
 *   [NNL].%d.%d
 *   Boot Loader version %d.%d
 *   FW Timestamp [DD-MM-YYYY HH:MM:SS] %02d-%02d-20%02d
 *   [NNL] %02d:%02d:%02d
 *   Number of FW capability bit masks: %d
 *   WMI_FW_VER_EVENTID: FW capability bitmask %d = 0x%08X
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, mac__read_880a00_0c, mac__read_880a14_28, mac__read_880a2c_38, mem_pool__alloc_locked, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_fw_ver
wmi_fw_ver:
	.global L_8dd130
L_8dd130:
	push_s blink
L_8dd132:
	bl L_8c01d4
L_8dd136:
	sub_s sp,sp,0xc
L_8dd138:
	mov_s r17,r0
L_8dd13a:
	mov_s r18,r1
L_8dd13c:
	mov_s r15,0x0
L_8dd13e:
	bl.d L_8c33d0
L_8dd142:
	st_s r15,[sp,0x4]
L_8dd144:
	mov.f r13,r0
L_8dd148:
	add r16,r0,0x3c
L_8dd14c:
	beq_s L_8dd290
	.global L_8dd14e
L_8dd14e:
	mov_s r0,r13
L_8dd150:
	bl.d L_8c1cd8
L_8dd154:
	mov_s r1,0x3c
L_8dd156:
	add_s r1,r13,0x4
L_8dd158:
	add r2,r13,0x8
L_8dd15c:
	add r3,r13,0xc
L_8dd160:
	bl.d L_8f3570
L_8dd164:
	mov_s r0,r13
L_8dd166:
	add r0,r13,0x18
L_8dd16a:
	add r1,r13,0x14
L_8dd16e:
	add r2,r13,0x10
L_8dd172:
	add r3,r13,0x1c
L_8dd176:
	add r4,r13,0x20
L_8dd17a:
	bl.d L_8f3354
L_8dd17e:
	add r5,r13,0x24
L_8dd182:
	add r0,r13,0x28
L_8dd186:
	add r1,r13,0x2c
L_8dd18a:
	add r2,r13,0x30
L_8dd18e:
	bl.d L_8f34c4
L_8dd192:
	add r3,r13,0x34
L_8dd196:
	mov_s r1,0x100631c
L_8dd19c:
	bl.d L_8dcba8
L_8dd1a0:
	mov_s r0,0x20
L_8dd1a2:
	ld_s r2,[r13]
L_8dd1a4:
	mov_s r1,0x1006344
L_8dd1aa:
	mov_s r0,0x20
L_8dd1ac:
	bl.d L_8dcc80
L_8dd1b0:
	ld_s r3,[r13,0x4]
L_8dd1b2:
	mov_s r14,0x1006358
L_8dd1b8:
	ld_s r2,[r13,0x8]
L_8dd1ba:
	mov_s r0,0x20
L_8dd1bc:
	mov_s r1,r14
L_8dd1be:
	bl.d L_8dcc80
L_8dd1c2:
	ld_s r3,[r13,0xc]
L_8dd1c4:
	mov_s r1,0x1006364
L_8dd1ca:
	ld_s r2,[r13,0x28]
L_8dd1cc:
	mov_s r0,0x20
L_8dd1ce:
	bl.d L_8dcc80
L_8dd1d2:
	ld_s r3,[r13,0x2c]
L_8dd1d4:
	mov_s r0,0x20
L_8dd1d6:
	ld_s r2,[r13,0x30]
L_8dd1d8:
	mov_s r1,r14
L_8dd1da:
	bl.d L_8dcc80
L_8dd1de:
	ld_s r3,[r13,0x34]
L_8dd1e0:
	mov_s r1,0x1006380
L_8dd1e6:
	ld r4,[r13, 0x24]
L_8dd1ea:
	mov_s r0,0x20
L_8dd1ec:
	ld_s r2,[r13,0x1c]
L_8dd1ee:
	bl.d L_8dcd00
L_8dd1f2:
	ld_s r3,[r13,0x20]
L_8dd1f4:
	mov_s r1,0x10063b4
L_8dd1fa:
	ld r4,[r13, 0x18]
L_8dd1fe:
	mov_s r0,0x20
L_8dd200:
	ld_s r2,[r13,0x10]
L_8dd202:
	bl.d L_8dcd00
L_8dd206:
	ld_s r3,[r13,0x14]
L_8dd208:
	add_s r0,sp,0x4
L_8dd20a:
	bl.d L_8f3560
L_8dd20e:
	add_s r1,sp,0x8
L_8dd210:
	mov_s r1,0x10063cc
L_8dd216:
	mov_s r0,0x20
L_8dd218:
	bl.d L_8dcc10
L_8dd21c:
	ldb_s r2,[sp,0x8]
L_8dd21e:
	ldb_s r0,[sp,0x8]
L_8dd220:
	brlt.d r0,0x1,L_8dd24e
L_8dd224:
	mov_s r14,0x0
	.global L_8dd226
L_8dd226:
	ld_s r0,[sp,0x4]
L_8dd228:
	add2 r12,r16,r14
L_8dd22c:
	ld.as r0,[r0,r14]
L_8dd230:
	mov_s r1,0x10063f4
L_8dd236:
	st_s r0,[r12]
L_8dd238:
	ld_s r0,[sp,0x4]
L_8dd23a:
	ld.as r3,[r0,r14]
L_8dd23e:
	mov_s r0,0x20
L_8dd240:
	bl.d L_8dcc80
L_8dd244:
	mov_s r2,r14
L_8dd246:
	ldb_s r0,[sp,0x8]
L_8dd248:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8dd24a:
	brlt r14,r0,L_8dd226
	.global L_8dd24e
L_8dd24e:
	stb r0,[r13, 0x38]
L_8dd252:
	ldb_s r14,[sp,0x8]
L_8dd254:
	mov_s r1,0x100642c
L_8dd25a:
	/* asl_s r14,r14,0x2 */
	.byte 0x02,0xbe
L_8dd25c:
	add r16,r14,0x3c
L_8dd260:
	extw r16,r16
L_8dd264:
	mov_s r0,0x20
L_8dd266:
	bl.d L_8dcc10
L_8dd26a:
	mov_s r2,r16
L_8dd26c:
	st_s r15,[sp,0x0]
L_8dd26e:
	mov_s r0,r17
L_8dd270:
	mov_s r1,r13
L_8dd272:
	mov_s r2,0x0
L_8dd274:
	mov_s r3,0x9004
L_8dd27a:
	mov r4,r16
L_8dd27e:
	mov r5,r18
L_8dd282:
	mov_s r6,r2
L_8dd284:
	bl.d L_8e4fc4
L_8dd288:
	mov_s r7,r2
L_8dd28a:
	b.d L_8c0234
L_8dd28e:
	add_s sp,sp,0xc
	.global L_8dd290
L_8dd290:
	mov_s r0,blink
L_8dd292:
	mov_s r1,0x39
L_8dd294:
	bl.d L_8c9b28
L_8dd298:
	bset_s r1,r1,0xc
L_8dd29a:
	b_s L_8dd14e
