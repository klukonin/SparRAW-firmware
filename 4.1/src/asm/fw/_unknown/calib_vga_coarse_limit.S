/* calib_vga_coarse_limit @ 0x8d5274, 200 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *         Coarse VGA (%d) reached its limit (%d)
 * Зовут его: calib_vga_coarse
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit2, memcpy_fw
 */
	.section .text.calib_vga_coarse_limit,"ax",@progbits
	.global calib_vga_coarse_limit
calib_vga_coarse_limit:
	.global L_8d5274
L_8d5274:
	sub_s sp,sp,0x20
L_8d5276:
	push_s blink
L_8d5278:
	bl L_8c02b4
L_8d527c:
	sub_s sp,sp,0x4
L_8d527e:
	ld_s r1,[sp,0x54]
L_8d5280:
	st_s r0,[sp,0x20]
L_8d5282:
	cmp_s r1,0x0
L_8d5284:
	mov_s r0,0x0
L_8d5286:
	mov.ne r15,0x6
L_8d528a:
	mov.ne r2,0xffffffff
L_8d5292:
	bne_s L_8d529a
L_8d5294:
	ldb_s r0,[sp,0x20]
L_8d5296:
	mov_s r15,0x2
L_8d5298:
	mov_s r2,0x1
	.global L_8d529a
L_8d529a:
	ld_s r13,[sp,0x48]
L_8d529c:
	mov_s r18,r2
L_8d529e:
	ld_s r2,[sp,0x4c]
L_8d52a0:
	ldb_s r3,[r2]
L_8d52a2:
	brne r13,0x1,L_8d52be
L_8d52a6:
	ld_s r14,[sp,0x44]
L_8d52a8:
	ldb_s r2,[r14]
L_8d52aa:
	brne r0,r2,L_8d52b4
L_8d52ae:
	stb_s r15,[r14]
L_8d52b0:
	mov_s r13,0x0
L_8d52b2:
	b_s L_8d52be
	.global L_8d52b4
L_8d52b4:
	add_s r2,r2,r18
L_8d52b6:
	stb_s r2,[r14]
L_8d52b8:
	ld_s r0,[sp,0x58]
L_8d52ba:
	mov_s r2,0x1
L_8d52bc:
	stb_s r2,[r0]
	.global L_8d52be
L_8d52be:
	brne_s r13,0,L_8d5332
L_8d52c0:
	ld_s r13,[sp,0x44]
L_8d52c2:
	sub r13,r13,0x20
L_8d52c6:
	add_s r13,r13,r3
L_8d52c8:
	ldb r16,[r13, 0x1f]
L_8d52cc:
	cmp r16,0x0
L_8d52d0:
	cmp.eq r1,0x1
L_8d52d4:
	beq_s L_8d52ec
L_8d52d6:
	sub3 r14,sp,0x10
L_8d52da:
	add1 r17,r14,0x3f
L_8d52de:
	add_s r14,r14,r3
L_8d52e0:
	ldb r0,[r14, 0x9f]
L_8d52e4:
	cmp_s r0,r16
L_8d52e6:
	cmp.eq r1,0x0
L_8d52ea:
	bne_s L_8d5306
	.global L_8d52ec
L_8d52ec:
	mov_s r2,0x1017bb8
L_8d52f2:
	mov_s r0,0x6
L_8d52f4:
	mov_s r1,0x0
L_8d52f6:
	bl.d L_8edff8
L_8d52fa:
	mov r4,r16
L_8d52fe:
	mov_s r1,0x2
L_8d5300:
	ld_s r0,[sp,0x5c]
L_8d5302:
	st_s r1,[r0]
L_8d5304:
	b_s L_8d5332
	.global L_8d5306
L_8d5306:
	mov_s r0,sp
L_8d5308:
	mov_s r1,0x802f14
L_8d530e:
	bl.d L_8c0460
L_8d5312:
	mov_s r2,0x3
L_8d5314:
	add r0,r16,r18
L_8d5318:
	extb_s r0,r0
L_8d531a:
	stb_s r0,[r13,0x1f]
L_8d531c:
	ld_s r0,[sp,0x58]
L_8d531e:
	ldb r1,[r14, 0x7e]
L_8d5322:
	stb_s r1,[r0]
L_8d5324:
	ldb_s r0,[sp,0x50]
L_8d5326:
	brne r1,r0,L_8d532e
L_8d532a:
	ldb r1,[r17,r1]
	.global L_8d532e
L_8d532e:
	ld_s r0,[sp,0x4c]
L_8d5330:
	stb_s r1,[r0]
	.global L_8d5332
L_8d5332:
	mov_s r12,0x24
L_8d5334:
	b.d L_8c0316
L_8d5338:
	add_s sp,sp,0x4
L_8d533a:
	nop_s
