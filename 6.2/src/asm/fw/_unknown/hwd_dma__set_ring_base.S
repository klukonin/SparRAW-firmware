/* hwd_dma__set_ring_base @ 0x8d0468, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__configure_ring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, dpal__cpl_timeout_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__set_ring_base
hwd_dma__set_ring_base:
	.global L_8d0468
L_8d0468:
	push_s blink
L_8d046a:
	bl.d L_8c01e0
L_8d046e:
	mov_s r6,r2
L_8d0470:
	mov_s r14,r3
L_8d0472:
	mov_s r15,r4
L_8d0474:
	cmp r5,0x0
L_8d0478:
	mul64 r0,0x380
L_8d047c:
	mov_s r13,mlo
L_8d047e:
	add r0,r13,0x4409940
L_8d0486:
	lsr_s r0,r0,0x3
L_8d0488:
	bic r0,r0,0x3
L_8d048c:
	st_s r1,[r0]
L_8d048e:
	bl.ne.d L_8c9680
L_8d0492:
	mov.ne r0,r6
L_8d0496:
	add r0,r13,0x4409720
L_8d049e:
	lsr_s r0,r0,0x3
L_8d04a0:
	bic r0,r0,0x3
L_8d04a4:
	st_s r14,[r0]
L_8d04a6:
	add_s r13,r13,0x4409740
L_8d04ac:
	lsr_s r13,r13,0x3
L_8d04ae:
	bic r13,r13,0x3
L_8d04b2:
	st_s r15,[r13]
L_8d04b4:
	b L_8c024c
