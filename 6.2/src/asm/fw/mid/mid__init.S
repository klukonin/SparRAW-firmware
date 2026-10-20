/* mid__init @ 0x8d95b4, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__open
 * Зовёт сам: __ld_r13_to_r13_ret, app_ies__clear, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__init
mid__init:
	.global L_8d95b4
L_8d95b4:
	push_s blink
L_8d95b6:
	push_s r13
L_8d95b8:
	mov_s r13,r0
L_8d95ba:
	mov_s r0,0x0
L_8d95bc:
	st_s r0,[r13,0x4]
L_8d95be:
	mov_s r2,0x1
L_8d95c0:
	st_s r2,[r13,0x8]
L_8d95c2:
	st_s r1,[r13]
L_8d95c4:
	st.as r0,[r13,0x6b]
L_8d95c8:
	st.as r0,[r13,0x6a]
L_8d95cc:
	st_s r0,[r13,0x48]
L_8d95ce:
	mov r3,0x3e8
L_8d95d2:
	add3 r1,r13,0x8
L_8d95d6:
	stw_s r3,[r1,0x12]
L_8d95d8:
	st_s r0,[r13,0x58]
L_8d95da:
	stb_s r0,[r1,0x14]
L_8d95dc:
	mov lp_count,0x8
L_8d95e0:
	stb_s r2,[r1,0x15]
L_8d95e2:
	lp L_8d95f6
L_8d95e6:
	mul64 r0,0x11
L_8d95ea:
	mov_s r1,r13
L_8d95ec:
	add_s r1,r1,0x75
L_8d95ee:
	mov_s r2,0x8
L_8d95f0:
	add_s r1,r1,mlo
L_8d95f2:
	stb_s r2,[r1]
L_8d95f4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8d95f6
L_8d95f6:
	bl.d L_8c6784
L_8d95fa:
	add3 r0,r13,0x36
L_8d95fe:
	brne_s r0,0,L_8d9626
	.global L_8d9600
L_8d9600:
	mov_s r0,r13
L_8d9602:
	bl.d L_8c6784
L_8d9606:
	add r0,r0,0x1bc
L_8d960a:
	brne_s r0,0,L_8d9634
	.global L_8d960c
L_8d960c:
	bl.d L_8c6784
L_8d9610:
	add3 r0,r13,0x39
L_8d9614:
	brne_s r0,0,L_8d9642
	.global L_8d9616
L_8d9616:
	mov_s r0,r13
L_8d9618:
	bl.d L_8c6784
L_8d961c:
	add r0,r0,0x1d4
L_8d9620:
	brne_s r0,0,L_8d9650
	.global L_8d9622
L_8d9622:
	b L_8c025c
	.global L_8d9626
L_8d9626:
	mov_s r0,blink
L_8d9628:
	mov_s r1,0x11ef
L_8d962e:
	bl L_8c9b28
L_8d9632:
	b_s L_8d9600
	.global L_8d9634
L_8d9634:
	mov_s r0,blink
L_8d9636:
	mov_s r1,0x11f0
L_8d963c:
	bl L_8c9b28
L_8d9640:
	b_s L_8d960c
	.global L_8d9642
L_8d9642:
	mov_s r0,blink
L_8d9644:
	mov_s r1,0x11f1
L_8d964a:
	bl L_8c9b28
L_8d964e:
	b_s L_8d9616
	.global L_8d9650
L_8d9650:
	mov_s r0,blink
L_8d9652:
	mov_s r1,0x11f2
L_8d9658:
	bl L_8c9b28
L_8d965c:
	b_s L_8d9622
L_8d965e:
	nop_s
