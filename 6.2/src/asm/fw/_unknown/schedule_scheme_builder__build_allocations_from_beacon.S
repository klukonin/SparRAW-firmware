/* schedule_scheme_builder__build_allocations_from_beacon @ 0x8c5248, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   schedule_scheme_builder::build_allocations_from_beacon: Finished processing. Got %d slots for me from total of %d slots
 * Зовут его: dmg_bcon__build_allocations
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, cid_pair__matches, ese__alloc_to_slot, fw_divmod_signed, fw_log_emit2, mac__get_bi_start_tsf, sched__alloc_changed, sched_builder__reset_alloc_list, schedule_scheme__sum_two
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global schedule_scheme_builder__build_allocations_from_beacon
schedule_scheme_builder__build_allocations_from_beacon:
	.global L_8c5248
L_8c5248:
	push_s blink
L_8c524a:
	bl.d L_8c01d4
L_8c524e:
	mov_s r2,0x2
L_8c5250:
	mov_s r14,r0
L_8c5252:
	ld_s r0,[r0]
L_8c5254:
	ld_s r0,[r0,0x4]
L_8c5256:
	stb_s r2,[r0]
L_8c5258:
	mov_s r0,0x1
L_8c525a:
	st_s r0,[r14,0xc]
L_8c525c:
	ld_s r13,[r1,0x4]
L_8c525e:
	ldb_s r0,[r1,0x1]
L_8c5260:
	bl.d L_8c02dc
L_8c5264:
	mov_s r1,0xf
L_8c5266:
	extb r16,r0
L_8c526a:
	mov_s r0,r14
L_8c526c:
	mov_s r1,r13
L_8c526e:
	bl.d L_8da3f4
L_8c5272:
	mov_s r2,r16
L_8c5274:
	breq_s r0,0,L_8c52c6
L_8c5276:
	bl.d L_8e2948
L_8c527a:
	ld_s r0,[r14]
L_8c527c:
	bl.d L_8e457c
L_8c5280:
	mov_s r15,0x0
L_8c5282:
	brlt.d r16,0x1,L_8c52b0
L_8c5286:
	mov_s r18,r0
L_8c5288:
	mov_s r0,r16
	.global L_8c528a
L_8c528a:
	mov_s r17,r0
L_8c528c:
	ldb_s r1,[r13,0x4]
L_8c528e:
	mov_s r0,r14
L_8c5290:
	bl.d L_8da62c
L_8c5294:
	ldb_s r2,[r13,0x5]
L_8c5296:
	breq_s r0,0,L_8c52a6
L_8c5298:
	mov_s r0,r14
L_8c529a:
	mov_s r1,r18
L_8c529c:
	bl.d L_8c7d4c
L_8c52a0:
	mov_s r2,r13
L_8c52a2:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8c52a4:
	extb_s r15,r15
	.global L_8c52a6
L_8c52a6:
	sub r0,r17,0x1
L_8c52aa:
	brhs.d r0,0x1,L_8c528a
L_8c52ae:
	add_s r13,r13,0xf
	.global L_8c52b0
L_8c52b0:
	mov_s r1,0x1014498
L_8c52b6:
	mov_s r0,0x2b
L_8c52b8:
	mov_s r2,r15
L_8c52ba:
	bl.d L_8dcc80
L_8c52be:
	mov_s r3,r16
L_8c52c0:
	bl.d L_8e0d48
L_8c52c4:
	mov_s r0,r14
	.global L_8c52c6
L_8c52c6:
	b L_8c0234
L_8c52ca:
	nop_s
