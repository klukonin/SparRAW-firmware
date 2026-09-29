/* vring_schd__add_sniffer_vring @ 0x8c2568, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schdlr.cpp
 * Зовут его: sniffer_mode_step
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal, vring_cfg__init
 */
	.section .text.vring_schd__add_sniffer_vring,"ax",@progbits
	.global vring_schd__add_sniffer_vring
vring_schd__add_sniffer_vring:
	.global L_8c2568
L_8c2568:
	push_s blink
L_8c256a:
	bl L_8c02b8
L_8c256e:
	mov_s r13,r0
L_8c2570:
	mov_s r17,r1
L_8c2572:
	mov_s r1,0x804600
L_8c2578:
	ld_s r0,[r1,0x14]
L_8c257a:
	mov_s r14,0x804580
L_8c2580:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c2582:
	mov_s r16,r2
L_8c2584:
	brhs.d r0,0x3,L_8c25a2
L_8c2588:
	st_s r0,[r1,0x14]
	.global L_8c258a
L_8c258a:
	mul64 r13,0x38
L_8c258e:
	add r0,r14,0x24
L_8c2592:
	extw_s r1,r13
L_8c2594:
	mov_s r2,r17
L_8c2596:
	add_s r0,r0,mlo
L_8c2598:
	bl.d L_8d6104
L_8c259c:
	mov_s r3,r16
L_8c259e:
	b L_8c031c
	.global L_8c25a2
L_8c25a2:
	mov_s r0,blink
L_8c25a4:
	mov_s r2,0x100a584
L_8c25aa:
	mov_s r1,0x12b5
L_8c25b0:
	bl.d L_8c82c0
L_8c25b4:
	mov_s r3,0xb8
L_8c25b6:
	b_s L_8c258a
