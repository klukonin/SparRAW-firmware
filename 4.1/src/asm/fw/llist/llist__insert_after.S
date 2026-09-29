/* llist__insert_after @ 0x8c20a4, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   llist.cpp
 * Зовут его: sorted_llist__insert
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.llist__insert_after,"ax",@progbits
	.global llist__insert_after
llist__insert_after:
	.global L_8c20a4
L_8c20a4:
	push_s blink
L_8c20a6:
	bl L_8c02c0
L_8c20aa:
	mov.f r13,r1
L_8c20ae:
	mov_s r14,r0
L_8c20b0:
	mov_s r15,r2
L_8c20b2:
	beq_s L_8c20de
	.global L_8c20b4
L_8c20b4:
	ld_s r0,[r13,0x4]
L_8c20b6:
	brne_s r0,0,L_8c20f0
	.global L_8c20b8
L_8c20b8:
	breq_s r15,0,L_8c2102
	.global L_8c20ba
L_8c20ba:
	ld_s r0,[r15,0x4]
L_8c20bc:
	brne r14,r0,L_8c2114
	.global L_8c20c0
L_8c20c0:
	ld_s r0,[r14]
L_8c20c2:
	breq_s r0,0,L_8c2126
	.global L_8c20c4
L_8c20c4:
	ld_s r0,[r15]
L_8c20c6:
	st_s r13,[r15]
L_8c20c8:
	st_s r0,[r13]
L_8c20ca:
	ld_s r0,[r14,0x8]
L_8c20cc:
	brne r15,r0,L_8c20d2
L_8c20d0:
	st_s r13,[r14,0x8]
	.global L_8c20d2
L_8c20d2:
	ld_s r0,[r14]
L_8c20d4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c20d6:
	st_s r0,[r14]
L_8c20d8:
	b.d L_8c032c
L_8c20dc:
	st_s r14,[r13,0x4]
	.global L_8c20de
L_8c20de:
	mov_s r0,blink
L_8c20e0:
	mov_s r2,0x1001de0
L_8c20e6:
	mov_s r1,0xd5
L_8c20e8:
	bl.d L_8c82c0
L_8c20ec:
	mov_s r3,0x3e
L_8c20ee:
	b_s L_8c20b4
	.global L_8c20f0
L_8c20f0:
	mov_s r0,blink
L_8c20f2:
	mov_s r2,0x1001de0
L_8c20f8:
	mov_s r1,0xd6
L_8c20fa:
	bl.d L_8c82c0
L_8c20fe:
	mov_s r3,0x3f
L_8c2100:
	b_s L_8c20b8
	.global L_8c2102
L_8c2102:
	mov_s r0,blink
L_8c2104:
	mov_s r2,0x1001de0
L_8c210a:
	mov_s r1,0xd7
L_8c210c:
	bl.d L_8c82c0
L_8c2110:
	mov_s r3,0x40
L_8c2112:
	b_s L_8c20ba
	.global L_8c2114
L_8c2114:
	mov_s r0,blink
L_8c2116:
	mov_s r2,0x1001de0
L_8c211c:
	mov_s r1,0xd8
L_8c211e:
	bl.d L_8c82c0
L_8c2122:
	mov_s r3,0x41
L_8c2124:
	b_s L_8c20c0
	.global L_8c2126
L_8c2126:
	mov_s r0,blink
L_8c2128:
	mov_s r2,0x1001de0
L_8c212e:
	mov_s r1,0xd9
L_8c2130:
	bl.d L_8c82c0
L_8c2134:
	mov_s r3,0x42
L_8c2136:
	b_s L_8c20c4
