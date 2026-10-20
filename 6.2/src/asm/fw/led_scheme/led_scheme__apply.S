/* led_scheme__apply @ 0x8da84c, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main, fw_sysassert_fatal, led__update_by_link_rate, lmac_if__lmac_ready_evt, sm_802f58__action_8e774c, sm_802f58__action_8e7e60
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, hw_ch__enable_once, u_schd__cancel, u_schd__schedule
 * Глобалы (через gp): 0x8003bc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global led_scheme__apply
led_scheme__apply:
	.global L_8da84c
L_8da84c:
	push_s blink
L_8da84e:
	bl L_8c01e0
L_8da852:
	brhs.d r0,0x7,L_8da8aa
L_8da856:
	mov_s r14,r0
	.global L_8da858
L_8da858:
	mov_s r13,0x8004f4
L_8da85e:
	ld_s r0,[r13]
L_8da860:
	breq_s r0,0,L_8da86a
L_8da862:
	bl L_8c8de0
L_8da866:
	mov_s r0,0x0
L_8da868:
	st_s r0,[r13]
	.global L_8da86a
L_8da86a:
	add_s r14,r14,r14
L_8da86c:
	add1_s r14,r14,r14
L_8da86e:
	add r0,r14,0x803c00
L_8da876:
	ldw_s r1,[r0,0x2e]
L_8da878:
	ldw_s r14,[r0,0x2a]
L_8da87a:
	ldw_s r15,[r0,0x2c]
L_8da87c:
	breq_s r1,0,L_8da89c
L_8da87e:
	mulu64 r1,0x3e8
L_8da882:
	mov_s r1,0x0
L_8da884:
	mov_s r0,0x1a8b8
L_8da88a:
	mov_s r2,r1
L_8da88c:
	mov r4,mlo
L_8da890:
	mov_s r3,r1
L_8da892:
	mov_s r5,r1
L_8da894:
	bl.d L_8e0c0c
L_8da898:
	mov_s r6,r1
L_8da89a:
	st_s r0,[r13]
	.global L_8da89c
L_8da89c:
	ld_s r0,[gp,0x238]
L_8da89e:
	mov_s r1,r14
L_8da8a0:
	bl.d L_8da790
L_8da8a4:
	mov_s r2,r15
L_8da8a6:
	b L_8c024c
	.global L_8da8aa
L_8da8aa:
	mov_s r0,blink
L_8da8ac:
	mov_s r1,0x1158
L_8da8b2:
	bl L_8c9b28
L_8da8b6:
	b_s L_8da858
L_8da8b8:
	mov_s r0,0x8004f4
L_8da8be:
	mov_s r1,0x0
L_8da8c0:
	st_s r1,[r0]
L_8da8c2:
	ld_s r0,[gp,0x238]
L_8da8c4:
	b.d L_8da790
L_8da8c8:
	mov_s r2,0x64
L_8da8ca:
	nop_s
