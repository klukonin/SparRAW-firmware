/* hw_ch__enable_once @ 0x8da790, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: led_scheme__apply, led_scheme__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, hw_ch__noop_hook_a, hw_ch__noop_hook_b, range_check_lt3
 * Глобалы (через gp): 0x8003b0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_ch__enable_once
hw_ch__enable_once:
	.global L_8da790
L_8da790:
	push_s blink
L_8da792:
	bl L_8c01dc
L_8da796:
	mov_s r14,r0
L_8da798:
	ld_s r0,[gp,0x22c]
L_8da79a:
	mov_s r13,r1
L_8da79c:
	mov_s r15,r2
L_8da79e:
	breq_s r0,0,L_8da7ec
L_8da7a0:
	brhs r14,0x3,L_8da7cc
	.global L_8da7a4
L_8da7a4:
	mov_s r0,0x8019bc
L_8da7aa:
	add2 r16,r0,r14
L_8da7ae:
	ld r0,[r16]
L_8da7b2:
	brne_s r0,0,L_8da7c0
L_8da7b4:
	bl.d L_8da7fc
L_8da7b8:
	mov_s r0,r14
L_8da7ba:
	mov_s r1,0x1
L_8da7bc:
	st r1,[r16]
	.global L_8da7c0
L_8da7c0:
	brne_s r13,0,L_8da7d8
L_8da7c2:
	mov_s r0,r14
L_8da7c4:
	bl.d L_8da78c
L_8da7c8:
	mov_s r1,0x1
L_8da7ca:
	b_s L_8da7ec
	.global L_8da7cc
L_8da7cc:
	mov_s r0,blink
L_8da7ce:
	mov_s r1,0x8
L_8da7d0:
	bl.d L_8c9b28
L_8da7d4:
	bset_s r1,r1,0xc
L_8da7d6:
	b_s L_8da7a4
	.global L_8da7d8
L_8da7d8:
	mov_s r0,r14
L_8da7da:
	brne_s r15,0,L_8da7e4
L_8da7dc:
	bl.d L_8da78c
L_8da7e0:
	mov_s r1,0x0
L_8da7e2:
	b_s L_8da7ec
	.global L_8da7e4
L_8da7e4:
	mov_s r1,r13
L_8da7e6:
	bl.d L_8da75c
L_8da7ea:
	mov_s r2,r15
	.global L_8da7ec
L_8da7ec:
	b L_8c0244
