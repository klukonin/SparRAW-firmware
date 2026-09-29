/* list__find_entry_b @ 0x8c26b4, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: list__find_entry
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global list__find_entry_b
list__find_entry_b:
	.global L_8c26b4
L_8c26b4:
	push_s blink
L_8c26b6:
	bl L_8c01e0
L_8c26ba:
	mov.f r13,r1
L_8c26be:
	mov_s r14,r0
L_8c26c0:
	mov_s r15,r2
L_8c26c2:
	beq_s L_8c26ee
	.global L_8c26c4
L_8c26c4:
	ld_s r0,[r13,0x4]
L_8c26c6:
	brne_s r0,0,L_8c26f8
	.global L_8c26c8
L_8c26c8:
	breq_s r15,0,L_8c2702
	.global L_8c26ca
L_8c26ca:
	ld_s r0,[r15,0x4]
L_8c26cc:
	brne r14,r0,L_8c270c
	.global L_8c26d0
L_8c26d0:
	ld_s r0,[r14]
L_8c26d2:
	breq_s r0,0,L_8c2716
	.global L_8c26d4
L_8c26d4:
	ld_s r0,[r15]
L_8c26d6:
	st_s r13,[r15]
L_8c26d8:
	st_s r0,[r13]
L_8c26da:
	ld_s r0,[r14,0x8]
L_8c26dc:
	brne r15,r0,L_8c26e2
L_8c26e0:
	st_s r13,[r14,0x8]
	.global L_8c26e2
L_8c26e2:
	ld_s r0,[r14]
L_8c26e4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c26e6:
	st_s r0,[r14]
L_8c26e8:
	b.d L_8c024c
L_8c26ec:
	st_s r14,[r13,0x4]
	.global L_8c26ee
L_8c26ee:
	mov_s r0,blink
L_8c26f0:
	bl.d L_8c9b28
L_8c26f4:
	mov_s r1,0xd5
L_8c26f6:
	b_s L_8c26c4
	.global L_8c26f8
L_8c26f8:
	mov_s r0,blink
L_8c26fa:
	bl.d L_8c9b28
L_8c26fe:
	mov_s r1,0xd6
L_8c2700:
	b_s L_8c26c8
	.global L_8c2702
L_8c2702:
	mov_s r0,blink
L_8c2704:
	bl.d L_8c9b28
L_8c2708:
	mov_s r1,0xd7
L_8c270a:
	b_s L_8c26ca
	.global L_8c270c
L_8c270c:
	mov_s r0,blink
L_8c270e:
	bl.d L_8c9b28
L_8c2712:
	mov_s r1,0xd8
L_8c2714:
	b_s L_8c26d0
	.global L_8c2716
L_8c2716:
	mov_s r0,blink
L_8c2718:
	bl.d L_8c9b28
L_8c271c:
	mov_s r1,0xd9
L_8c271e:
	b_s L_8c26d4
