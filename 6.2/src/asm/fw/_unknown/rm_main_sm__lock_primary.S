/* rm_main_sm__lock_primary @ 0x8dc9a4, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::lock_primary. callback 0x%x for Handle:0x%x
 * Зовут его: rm_main_sm__get_next_prim_request
 * Зовёт сам: __ld_r14_to_r13_ret, __ld_r17_to_r13_ret, __st_r14_to_r13, __st_r17_to_r13, fw_log_emit2, fw_sysassert_fatal, list__find_entry_d, mem_pool__allocate, radio_mgr__enqueue_request, rm__llist_pop_front_thunk, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__lock_primary
rm_main_sm__lock_primary:
	.global L_8dc9a4
L_8dc9a4:
	push_s blink
L_8dc9a6:
	bl L_8c01e4
L_8dc9aa:
	mov_s r14,r0
L_8dc9ac:
	bl.d L_8e0bc8
L_8dc9b0:
	ld_s r0,[r0,0x8]
L_8dc9b2:
	mov_s r13,r0
L_8dc9b4:
	add2 r0,r14,0x1f
L_8dc9b8:
	bl.d L_8c25f4
L_8dc9bc:
	mov_s r1,r13
L_8dc9be:
	mov_s r0,0x3
L_8dc9c0:
	st_s r0,[r13,0x8]
L_8dc9c2:
	ldb_s r0,[r14,0x3]
L_8dc9c4:
	breq_s r0,0,L_8dc9d6
L_8dc9c6:
	ld_s r2,[r13,0xc]
L_8dc9c8:
	mov_s r1,0x1019204
L_8dc9ce:
	mov_s r0,0x28
L_8dc9d0:
	bl.d L_8dcc80
L_8dc9d4:
	mov_s r3,r13
	.global L_8dc9d6
L_8dc9d6:
	mov_s r0,0x246e8
L_8dc9dc:
	mov_s r1,r13
L_8dc9de:
	mov_s r2,0x0
L_8dc9e0:
	bl.d L_8c3248
L_8dc9e4:
	mov_s r3,0x1
L_8dc9e6:
	b L_8c0254
L_8dc9ea:
	nop_s
L_8dc9ec:
	push_s blink
L_8dc9ee:
	bl L_8c01d8
L_8dc9f2:
	mov_s r13,r0
L_8dc9f4:
	mov_s r15,r1
L_8dc9f6:
	mov_s r17,r2
L_8dc9f8:
	mov_s r16,r3
L_8dc9fa:
	bl.d L_8c354c
L_8dc9fe:
	/* _add_s r0,0x4 */
	.byte 0x04,0xe0
L_8dca00:
	mov.f r14,r0
L_8dca04:
	beq_s L_8dca28
	.global L_8dca06
L_8dca06:
	mov_s r0,0x0
L_8dca08:
	st_s r0,[r14,0x14]
L_8dca0a:
	st_s r15,[r14,0xc]
L_8dca0c:
	st r17,[r14, 0x10]
L_8dca10:
	mov_s r0,0x1
L_8dca12:
	st_s r0,[r14,0x8]
L_8dca14:
	stb r16,[r14, 0x20]
L_8dca18:
	add r0,r13,0x18
L_8dca1c:
	bl.d L_8e1f70
L_8dca20:
	mov_s r1,r14
L_8dca22:
	b.d L_8c023c
L_8dca26:
	mov_s r0,r14
	.global L_8dca28
L_8dca28:
	mov_s r0,blink
L_8dca2a:
	mov_s r1,0x115d
L_8dca30:
	bl L_8c9b28
L_8dca34:
	b_s L_8dca06
L_8dca36:
	nop_s
