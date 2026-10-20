/* mid__init @ 0x8d6568, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mid.cpp
 * Зовут его: mid__open
 * Зовёт сам: __ld_r13_ret, app_ies__clear, fw_sysassert_fatal
 */
	.section .text.mid__init,"ax",@progbits
	.global mid__init
mid__init:
	.global L_8d6568
L_8d6568:
	push_s blink
L_8d656a:
	push_s r13
L_8d656c:
	mov_s r13,r0
L_8d656e:
	mov_s r0,0x0
L_8d6570:
	st_s r0,[r13,0x4]
L_8d6572:
	mov_s r2,0x1
L_8d6574:
	st_s r2,[r13,0x8]
L_8d6576:
	st_s r1,[r13]
L_8d6578:
	st.as r0,[r13,0x6b]
L_8d657c:
	st.as r0,[r13,0x6a]
L_8d6580:
	st_s r0,[r13,0x48]
L_8d6582:
	mov r1,0x3e8
L_8d6586:
	stw r1,[r13, 0x52]
L_8d658a:
	st_s r0,[r13,0x58]
L_8d658c:
	mov lp_count,0x8
L_8d6590:
	stb r0,[r13, 0x54]
L_8d6594:
	lp L_8d65a8
L_8d6598:
	mul64 r0,0x11
L_8d659c:
	mov_s r1,r13
L_8d659e:
	add_s r1,r1,0x75
L_8d65a0:
	mov_s r2,0x8
L_8d65a2:
	add_s r1,r1,mlo
L_8d65a4:
	stb_s r2,[r1]
L_8d65a6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8d65a8
L_8d65a8:
	bl.d L_8c5a00
L_8d65ac:
	add3 r0,r13,0x36
L_8d65b0:
	brne_s r0,0,L_8d65d8
	.global L_8d65b2
L_8d65b2:
	mov_s r0,r13
L_8d65b4:
	bl.d L_8c5a00
L_8d65b8:
	add r0,r0,0x1bc
L_8d65bc:
	brne_s r0,0,L_8d65f0
	.global L_8d65be
L_8d65be:
	bl.d L_8c5a00
L_8d65c2:
	add3 r0,r13,0x39
L_8d65c6:
	brne_s r0,0,L_8d6608
	.global L_8d65c8
L_8d65c8:
	mov_s r0,r13
L_8d65ca:
	bl.d L_8c5a00
L_8d65ce:
	add r0,r0,0x1d4
L_8d65d2:
	brne_s r0,0,L_8d6620
	.global L_8d65d4
L_8d65d4:
	b L_8c033c
	.global L_8d65d8
L_8d65d8:
	mov_s r0,blink
L_8d65da:
	mov_s r2,0x100aedc
L_8d65e0:
	mov_s r1,0x11ef
L_8d65e6:
	bl.d L_8c82c0
L_8d65ea:
	mov r3,0x2e9
L_8d65ee:
	b_s L_8d65b2
	.global L_8d65f0
L_8d65f0:
	mov_s r0,blink
L_8d65f2:
	mov_s r2,0x100aedc
L_8d65f8:
	mov_s r1,0x11f0
L_8d65fe:
	bl.d L_8c82c0
L_8d6602:
	mov r3,0x2ea
L_8d6606:
	b_s L_8d65be
	.global L_8d6608
L_8d6608:
	mov_s r0,blink
L_8d660a:
	mov_s r2,0x100aedc
L_8d6610:
	mov_s r1,0x11f1
L_8d6616:
	bl.d L_8c82c0
L_8d661a:
	mov r3,0x2eb
L_8d661e:
	b_s L_8d65c8
	.global L_8d6620
L_8d6620:
	mov_s r0,blink
L_8d6622:
	mov_s r2,0x100aedc
L_8d6628:
	mov_s r1,0x11f2
L_8d662e:
	bl.d L_8c82c0
L_8d6632:
	mov r3,0x2ec
L_8d6636:
	b_s L_8d65d4
