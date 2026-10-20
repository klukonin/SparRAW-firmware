/* orig_fract @ 0x8dc4d8, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   0xfff: addr:%08x val:%08x mask:%08x
 *   delay:%u
 *   orig_fract:%u off:%u
 *   iter %u
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: fw_log_emit1, fw_log_emit2, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global orig_fract
orig_fract:
	.global L_8dc4d8
L_8dc4d8:
	push_s blink
L_8dc4da:
	ld r18,[r0, 0x4]
L_8dc4de:
	ld_s r15,[r0,0x8]
L_8dc4e0:
	mov_s r1,0x1006948
L_8dc4e6:
	ld r21,[r0, 0xc]
L_8dc4ea:
	mov_s r0,0x0
L_8dc4ec:
	mov_s r17,r0
L_8dc4ee:
	mov_s r2,r18
L_8dc4f0:
	mov_s r3,r15
L_8dc4f2:
	bl.d L_8dcd00
L_8dc4f6:
	mov r4,r21
L_8dc4fa:
	lsr r20,r21,0x8
L_8dc4fe:
	mov_s r1,0x100696c
L_8dc504:
	mov_s r0,0x0
L_8dc506:
	bl.d L_8dcc10
L_8dc50a:
	mov_s r2,r20
L_8dc50c:
	mov r19,0x88942c
L_8dc514:
	mov_s r0,0x889400
L_8dc51a:
	ld_s r2,[r0,0x24]
L_8dc51c:
	mov_s r0,r18
L_8dc51e:
	mulu64 r15,r0
L_8dc522:
	lsr r0,mlo
L_8dc526:
	sub r1,r2,r0
L_8dc52a:
	max r16,r1,0x0
L_8dc52e:
	mov_s r1,0x1006978
L_8dc534:
	mov_s r0,0x0
L_8dc536:
	mov_s r3,r16
L_8dc538:
	b_s L_8dc54a
	.global L_8dc53a
L_8dc53a:
	mov_s r1,0x1006990
L_8dc540:
	mov_s r13,0x0
L_8dc542:
	mov_s r0,r13
L_8dc544:
	mov_s r2,r17
L_8dc546:
	mov_s r3,r17
L_8dc548:
	mov_s r17,r13
	.global L_8dc54a
L_8dc54a:
	bl L_8dcc80
	.global L_8dc54e
L_8dc54e:
	bbit0 r21,0x1,L_8dc57c
L_8dc552:
	brlo.d r18,0x1,L_8dc57c
L_8dc556:
	mov_s r14,0x0
L_8dc558:
	mov_s r13,r18
	.global L_8dc55a
L_8dc55a:
	mulu64 r14,r15
L_8dc55e:
	add r3,mlo,r16
L_8dc562:
	st r3,[r19]
L_8dc566:
	mov lp_count,r20
L_8dc56a:
	nop_s
L_8dc56c:
	lp L_8dc574
L_8dc570:
	nop_s
L_8dc572:
	nop_s
	.global L_8dc574
L_8dc574:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8dc576:
	/* brhs.d r13,0x1,0x008dc55a */
	.byte 0xe7,0x0d,0x75,0x90
L_8dc57a:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8dc57c
L_8dc57c:
	bbit0 r21,0x0,L_8dc5ac
L_8dc580:
	sub r14,r18,0x1
L_8dc584:
	brlt r14,0x0,L_8dc5ac
L_8dc588:
	mov_s r13,r18
	.global L_8dc58a
L_8dc58a:
	mulu64 r14,r15
L_8dc58e:
	add r3,mlo,r16
L_8dc592:
	st r3,[r19]
L_8dc596:
	mov lp_count,r20
L_8dc59a:
	nop_s
L_8dc59c:
	lp L_8dc5a4
L_8dc5a0:
	nop_s
L_8dc5a2:
	nop_s
	.global L_8dc5a4
L_8dc5a4:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8dc5a6:
	brhs.d r13,0x1,L_8dc58a
L_8dc5aa:
	/* _sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
	.global L_8dc5ac
L_8dc5ac:
	add r17,r17,0x1
L_8dc5b0:
	brlt r17,0x2710,L_8dc54e
L_8dc5b8:
	b_s L_8dc53a
L_8dc5ba:
	nop_s
