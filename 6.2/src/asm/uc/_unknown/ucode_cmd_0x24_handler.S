/* ucode_cmd_0x24_handler @ 0x93a830, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   **********    DISCOVERY ON  (Type: %d) (tail: %d, head: %d)********
 *   [NNL] non_idle_mask: 0x%x
 *   **********    DISCOVERY OFF (Type: %d) (tail: %d, head: %d)********
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf_clear_all_sta, uc_log__emit1, uc_log__emit3, uc_sysassert, ucode_cmd_0x24__copy_byte_164, ucode_cmd_24__check
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x24_handler
ucode_cmd_0x24_handler:
	.global L_93a830
L_93a830:
	push_s blink
L_93a832:
	bl L_920234
L_93a836:
	ld_s r1,[r0,0x4]
L_93a838:
	stb r1,[gp, -0xf0]
L_93a83c:
	ld_s r0,[r0]
L_93a83e:
	extb_s r2,r1
L_93a840:
	breq_s r0,0,L_93a88a
L_93a842:
	breq r0,0x1,L_93a852
L_93a846:
	mov_s r0,blink
L_93a848:
	bl.d L_926618
L_93a84c:
	mov r1,0x104
L_93a850:
	b_s L_93a8ca
	.global L_93a852
L_93a852:
	mov_s r13,0x80207c
L_93a858:
	ld_s r3,[r13,0x44]
L_93a85a:
	mov_s r1,0x1001444
L_93a860:
	ld r4,[r13, 0x40]
L_93a864:
	bl.d L_92d338
L_93a868:
	mov_s r0,0x20
L_93a86a:
	ld_s r2,[r13,0x34]
L_93a86c:
	mov_s r1,0x1001488
L_93a872:
	bl.d L_92d1d0
L_93a876:
	mov_s r0,0x20
L_93a878:
	mov_s r0,0x802f80
L_93a87e:
	bl L_93d31c
L_93a882:
	mov_s r0,0x1
L_93a884:
	st.as r0,[gp,-0x20]
L_93a888:
	b_s L_93a8ca
	.global L_93a88a
L_93a88a:
	mov_s r14,0x80207c
L_93a890:
	ld_s r3,[r14,0x44]
L_93a892:
	mov_s r1,0x10014a4
L_93a898:
	ld r4,[r14, 0x40]
L_93a89c:
	bl.d L_92d338
L_93a8a0:
	mov_s r0,0x20
L_93a8a2:
	ld_s r2,[r14,0x34]
L_93a8a4:
	mov_s r1,0x1001488
L_93a8aa:
	bl.d L_92d1d0
L_93a8ae:
	mov_s r0,0x20
L_93a8b0:
	mov_s r0,0x0
L_93a8b2:
	st.as r0,[gp,-0x20]
L_93a8b6:
	mov_s r0,0x802f80
L_93a8bc:
	bl L_93dac0
L_93a8c0:
	ld_s r1,[r14,0x44]
L_93a8c2:
	ld_s r0,[r14,0x40]
L_93a8c4:
	cmp_s r1,r0
L_93a8c6:
	bl.hi L_9218b4
	.global L_93a8ca
L_93a8ca:
	b L_9202a4
L_93a8ce:
	nop_s
