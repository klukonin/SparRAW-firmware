/* arc_action_point__arm @ 0x8e9668, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   arc_action_point.c
 * Зовут его: arc_action_point__install_default
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.arc_action_point__arm,"ax",@progbits
	.global arc_action_point__arm
arc_action_point__arm:
	.global L_8e9668
L_8e9668:
	push_s blink
L_8e966a:
	push_s r13
L_8e966c:
	mov_s r13,r0
L_8e966e:
	mov_s r0,0x0
L_8e9670:
	bset_s r0,r0,0x18
L_8e9672:
	sr r0,[0x5]
L_8e9676:
	ld_s r0,[r13]
L_8e9678:
	brhs r0,0x2,L_8e96be
	.global L_8e967c
L_8e967c:
	ld_s r1,[r13,0x10]
L_8e967e:
	ld_s r2,[r13,0xc]
L_8e9680:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8e9682:
	or_s r2,r2,r1
L_8e9684:
	ld_s r1,[r13,0x14]
L_8e9686:
	ld_s r0,[r13]
L_8e9688:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8e968a:
	or_s r2,r2,r1
L_8e968c:
	ld_s r1,[r13,0x18]
L_8e968e:
	ld_s r3,[r13,0x4]
L_8e9690:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_8e9692:
	or_s r2,r2,r1
L_8e9694:
	ld_s r1,[r13,0x1c]
L_8e9696:
	add1_s r0,r0,r0
L_8e9698:
	asl_s r1,r1,0x8
L_8e969a:
	or_s r1,r1,r2
L_8e969c:
	mov_s r2,r0
L_8e969e:
	add r2,r2,0x220
L_8e96a2:
	sr r3,[r2]
L_8e96a6:
	ld_s r3,[r13,0x8]
L_8e96a8:
	mov_s r2,r0
L_8e96aa:
	add r2,r2,0x221
L_8e96ae:
	sr r3,[r2]
L_8e96b2:
	add r0,r0,0x222
L_8e96b6:
	b.d L_8c033c
L_8e96ba:
	sr r1,[r0]
	.global L_8e96be
L_8e96be:
	mov_s r0,blink
L_8e96c0:
	mov_s r2,0x1000b18
L_8e96c6:
	mov_s r1,0xf6
L_8e96c8:
	bl.d L_8c82c0
L_8e96cc:
	mov_s r3,0x38
L_8e96ce:
	b_s L_8e967c
