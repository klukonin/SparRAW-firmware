/* hwd_abif__write_checked @ 0x8cc188, 240 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, ut_hw_flows_cmd_0x404
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__write_checked,"ax",@progbits
	.global hwd_abif__write_checked
hwd_abif__write_checked:
	.global L_8cc188
L_8cc188:
	push_s blink
L_8cc18a:
	bl L_8c02b4
L_8cc18e:
	mov_s r14,r0
L_8cc190:
	mov_s r13,r1
L_8cc192:
	mov_s r15,r2
L_8cc194:
	mov_s r16,r3
L_8cc196:
	brge.d r1,0x8,L_8cc1f4
L_8cc19a:
	mov r17,r4
	.global L_8cc19e
L_8cc19e:
	brge r15,0x2,L_8cc20a
	.global L_8cc1a2
L_8cc1a2:
	brge r16,0x2,L_8cc220
	.global L_8cc1a6
L_8cc1a6:
	cmp_s r14,0x40
L_8cc1a8:
	bge L_8cc236
	.global L_8cc1ac
L_8cc1ac:
	rsub r18,r13,0x7
L_8cc1b0:
	extb r18,r18
L_8cc1b4:
	add1 r13,r16,r15
L_8cc1b8:
	brge.d r18,0x8,L_8cc24c
L_8cc1bc:
	extb_s r13,r13
	.global L_8cc1be
L_8cc1be:
	brge r13,0x4,L_8cc262
	.global L_8cc1c2
L_8cc1c2:
	add3 r0,r18,r13
L_8cc1c6:
	mov_s r1,0x8017c4
L_8cc1cc:
	ldb_s r3,[r1,r0]
L_8cc1ce:
	mov_s r1,0x8017e4
L_8cc1d4:
	ldb_s r2,[r1,r0]
L_8cc1d6:
	add3_s r3,r3,r14
L_8cc1d8:
	mov_s r1,0x88a608
L_8cc1de:
	add2_s r1,r1,r3
L_8cc1e0:
	ld_s r3,[r1]
L_8cc1e2:
	mov_s r0,0x1f
L_8cc1e4:
	asl_s r0,r0,r2
L_8cc1e6:
	bic_s r3,r3,r0
L_8cc1e8:
	asl r0,r17,r2
L_8cc1ec:
	or_s r3,r3,r0
L_8cc1ee:
	st_s r3,[r1]
L_8cc1f0:
	b L_8c0314
	.global L_8cc1f4
L_8cc1f4:
	mov_s r0,blink
L_8cc1f6:
	mov_s r2,0x1019954
L_8cc1fc:
	mov_s r1,0xb5
L_8cc1fe:
	bset_s r1,r1,0xc
L_8cc200:
	bl.d L_8c82c0
L_8cc204:
	mov r3,0x37f
L_8cc208:
	b_s L_8cc19e
	.global L_8cc20a
L_8cc20a:
	mov_s r0,blink
L_8cc20c:
	mov_s r2,0x1019954
L_8cc212:
	mov_s r1,0xb6
L_8cc214:
	bset_s r1,r1,0xc
L_8cc216:
	bl.d L_8c82c0
L_8cc21a:
	mov r3,0x380
L_8cc21e:
	b_s L_8cc1a2
	.global L_8cc220
L_8cc220:
	mov_s r0,blink
L_8cc222:
	mov_s r2,0x1019954
L_8cc228:
	mov_s r1,0xb7
L_8cc22a:
	bset_s r1,r1,0xc
L_8cc22c:
	bl.d L_8c82c0
L_8cc230:
	mov r3,0x381
L_8cc234:
	b_s L_8cc1a6
	.global L_8cc236
L_8cc236:
	mov_s r0,blink
L_8cc238:
	mov_s r2,0x1019954
L_8cc23e:
	mov_s r1,0xb8
L_8cc240:
	bset_s r1,r1,0xc
L_8cc242:
	bl.d L_8c82c0
L_8cc246:
	mov r3,0x382
L_8cc24a:
	b_s L_8cc1ac
	.global L_8cc24c
L_8cc24c:
	mov_s r0,blink
L_8cc24e:
	mov_s r2,0x1019954
L_8cc254:
	mov_s r1,0xb9
L_8cc256:
	bset_s r1,r1,0xc
L_8cc258:
	bl.d L_8c82c0
L_8cc25c:
	mov r3,0x38c
L_8cc260:
	b_s L_8cc1be
	.global L_8cc262
L_8cc262:
	mov_s r0,blink
L_8cc264:
	mov_s r2,0x1019954
L_8cc26a:
	mov_s r1,0xba
L_8cc26c:
	bset_s r1,r1,0xc
L_8cc26e:
	bl.d L_8c82c0
L_8cc272:
	mov r3,0x38d
L_8cc276:
	b_s L_8cc1c2
