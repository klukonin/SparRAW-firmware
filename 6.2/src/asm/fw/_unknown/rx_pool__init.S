/* rx_pool__init @ 0x8d928c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mem_pool__init, memset0_words, rx_macq__init, rx_pool__configure_ring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_pool__init
rx_pool__init:
	.global L_8d928c
L_8d928c:
	push_s blink
L_8d928e:
	bl L_8c01e4
L_8d9292:
	mov_s r13,0x84a940
L_8d9298:
	mov_s r1,0x3ea0
L_8d929e:
	bl.d L_8c1cd8
L_8d92a2:
	mov_s r0,r13
L_8d92a4:
	mov_s r14,0x805fe4
L_8d92aa:
	add r0,r14,0x1c
L_8d92ae:
	mov_s r1,r13
L_8d92b0:
	mov r2,0x538
L_8d92b4:
	bl.d L_8c7cf8
L_8d92b8:
	mov_s r3,0xc
L_8d92ba:
	bl L_8d97f4
L_8d92be:
	mov_s r13,0x843800
L_8d92c4:
	mov_s r0,r13
L_8d92c6:
	bl.d L_8c1cd8
L_8d92ca:
	mov r1,0x100
L_8d92ce:
	mov_s r0,r14
L_8d92d0:
	mov_s r1,r13
L_8d92d2:
	mov_s r2,0x8
L_8d92d4:
	bl.d L_8d8ef8
L_8d92d8:
	mov_s r3,0x4
L_8d92da:
	b L_8c0254
L_8d92de:
	nop_s
