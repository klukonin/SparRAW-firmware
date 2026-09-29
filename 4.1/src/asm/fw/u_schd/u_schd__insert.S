/* u_schd__insert @ 0x8dc99c, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   u_schd.cpp
 * Зовут его: u_schd__schedule
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_sysassert_fatal, sorted_llist__insert, u_schd__alloc_entry, u_schd__arm_timer, u_schd__fill_task, u_schd__fill_task_b
 */
	.section .text.u_schd__insert,"ax",@progbits
	.global u_schd__insert
u_schd__insert:
	.global L_8dc99c
L_8dc99c:
	push_s blink
L_8dc99e:
	bl L_8c02a8
L_8dc9a2:
	mov_s r14,r0
L_8dc9a4:
	mov_s r21,r1
L_8dc9a6:
	mov_s r20,r2
L_8dc9a8:
	mov_s r19,r3
L_8dc9aa:
	mov r18,r4
L_8dc9ae:
	mov_s r13,r5
L_8dc9b0:
	mov_s r15,r6
L_8dc9b2:
	bl.d L_8c2b88
L_8dc9b6:
	mov r16,r7
L_8dc9ba:
	mov_s r17,r0
L_8dc9bc:
	mov_s r1,r21
L_8dc9be:
	mov_s r2,r20
L_8dc9c0:
	bl.d L_8e204c
L_8dc9c4:
	mov_s r3,r19
L_8dc9c6:
	mov_s r0,r17
L_8dc9c8:
	mov_s r1,r13
L_8dc9ca:
	mov_s r2,r15
L_8dc9cc:
	mov_s r3,r16
L_8dc9ce:
	bl.d L_8e1444
L_8dc9d2:
	mov r4,r18
L_8dc9d6:
	mov_s r13,0x8034a8
L_8dc9dc:
	add2_s r13,r13,r14
L_8dc9de:
	ld_s r0,[r13]
L_8dc9e0:
	mov_s r2,0x2431c
L_8dc9e6:
	ld_s r14,[r0,0x4]
L_8dc9e8:
	bl.d L_8c2018
L_8dc9ec:
	mov_s r1,r17
L_8dc9ee:
	ld_s r0,[r13]
L_8dc9f0:
	ld_s r0,[r0,0x4]
L_8dc9f2:
	breq r14,r0,L_8dc9fc
L_8dc9f6:
	bl L_8de094
L_8dc9fa:
	breq_s r0,0,L_8dca02
	.global L_8dc9fc
L_8dc9fc:
	b.d L_8c02fc
L_8dca00:
	mov_s r0,r17
	.global L_8dca02
L_8dca02:
	mov_s r0,blink
L_8dca04:
	mov_s r2,0x1001708
L_8dca0a:
	mov_s r1,0x67
L_8dca0c:
	bset_s r1,r1,0xc
L_8dca0e:
	bl.d L_8c82c0
L_8dca12:
	mov_s r3,0xe6
L_8dca14:
	b_s L_8dc9fc
L_8dca16:
	nop_s
