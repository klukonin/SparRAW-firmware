/* ps_nonassoc_sm__rearm_timer @ 0x8dd420, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, ps_nonassoc_sm__cancel_timer, u_schd__schedule
 */
	.section .text.ps_nonassoc_sm__rearm_timer,"ax",@progbits
	.global ps_nonassoc_sm__rearm_timer
ps_nonassoc_sm__rearm_timer:
	.byte 0x4f
	.byte 0xf1
	.global sub_8dd422
sub_8dd422:
L_8dd422:
	nop_s
L_8dd424:
	push_s blink
L_8dd426:
	push_s r13
L_8dd428:
	mov_s r13,r0
L_8dd42a:
	ldb_s r0,[r0]
L_8dd42c:
	brne r0,0x2,L_8dd452
L_8dd430:
	bl.d L_8dd1a0
L_8dd434:
	mov_s r0,r13
L_8dd436:
	mov_s r0,0x1d368
L_8dd43c:
	ld.as r4,[gp,-0x13]
L_8dd440:
	mov_s r1,r13
L_8dd442:
	mov_s r2,0x0
L_8dd444:
	mov_s r3,0x1
L_8dd446:
	mov_s r5,r2
L_8dd448:
	bl.d L_8dc92c
L_8dd44c:
	mov_s r6,r2
L_8dd44e:
	st.as r0,[gp,-0x15]
	.global L_8dd452
L_8dd452:
	.byte 0xed,0x06
