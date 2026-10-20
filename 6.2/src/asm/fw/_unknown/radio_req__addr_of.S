/* radio_req__addr_of @ 0x8f3698, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__init_scan_and_pools
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, list__find_entry_d, llist__pop_front
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global radio_req__addr_of
radio_req__addr_of:
	.global L_8f3698
L_8f3698:
	mul64 r0,0x228
L_8f369c:
	add r0,mlo,0x8052ec
L_8f36a4:
	j_s [blink]
L_8f36a6:
	nop_s
L_8f36a8:
	push_s blink
L_8f36aa:
	bl L_8c01d8
L_8f36ae:
	mov_s r14,r0
L_8f36b0:
	mov_s r17,r1
L_8f36b2:
	ld_s r1,[r0,0x4]
L_8f36b4:
	ld_s r0,[r0,0x8]
L_8f36b6:
	cmp_s r0,r1
L_8f36b8:
	mov.cc r13,r1
L_8f36bc:
	mov.cs r13,r0
L_8f36c0:
	brlo.d r13,0x1,L_8f36fa
L_8f36c4:
	mov_s r16,r2
L_8f36c6:
	mov_s r15,r13
	.global L_8f36c8
L_8f36c8:
	bl.d L_8e2674
L_8f36cc:
	mov_s r0,r16
L_8f36ce:
	mov_s r1,r0
L_8f36d0:
	ldw_s r0,[r14,0xe]
L_8f36d2:
	cmp_s r0,0x0
L_8f36d4:
	mov.le r0,0x0
L_8f36d8:
	ble_s L_8f36e0
L_8f36da:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8f36dc:
	stw_s r0,[r14,0xe]
L_8f36de:
	mov_s r0,0x1
	.global L_8f36e0
L_8f36e0:
	stb_s r0,[r1,0x11]
L_8f36e2:
	bl.d L_8c25f4
L_8f36e6:
	mov_s r0,r17
L_8f36e8:
	ld_s r0,[r14,0x4]
L_8f36ea:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8f36ec:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8f36ee:
	st_s r0,[r14,0x4]
L_8f36f0:
	ld_s r0,[r14,0x8]
L_8f36f2:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8f36f4:
	brhs.d r15,0x1,L_8f36c8
L_8f36f8:
	st_s r0,[r14,0x8]
	.global L_8f36fa
L_8f36fa:
	ld_s r0,[r14,0x1c]
L_8f36fc:
	add_s r0,r0,r13
L_8f36fe:
	b.d L_8c023c
L_8f3702:
	st_s r0,[r14,0x1c]
