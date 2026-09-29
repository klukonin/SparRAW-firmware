/* mac__set_usec_clk_div @ 0x8e99dc, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__pll_mode_switch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac__reload_tsf64, mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__set_usec_clk_div
mac__set_usec_clk_div:
	.global L_8e99dc
L_8e99dc:
	push_s blink
L_8e99de:
	bl L_8c01e4
L_8e99e2:
	sub_s sp,sp,0x8
L_8e99e4:
	lsr_s r13,r0
L_8e99e6:
	mov_s r14,0x886d00
L_8e99ec:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e99ee:
	asl_s r13,r13,0x10
L_8e99f0:
	or_s r13,r13,r0
L_8e99f2:
	breq_s r1,0,L_8e9a0a
L_8e99f4:
	mov_s r1,sp
L_8e99f6:
	mov_s r0,0x0
L_8e99f8:
	bl.d L_8e9900
L_8e99fc:
	mov_s r2,r0
L_8e99fe:
	st_s r13,[r14,0x58]
L_8e9a00:
	ld_s r0,[sp,0x0]
L_8e9a02:
	bl.d L_8e9a58
L_8e9a06:
	ld_s r1,[sp,0x4]
L_8e9a08:
	b_s L_8e9a0c
	.global L_8e9a0a
L_8e9a0a:
	st_s r13,[r14,0x58]
	.global L_8e9a0c
L_8e9a0c:
	b.d L_8c0254
L_8e9a10:
	add_s sp,sp,0x8
L_8e9a12:
	nop_s
