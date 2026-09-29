/* hwd_dma__set_ring_base @ 0x8cd5dc, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__configure_ring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, hwd_dma__set_881c80
 */
	.section .text.hwd_dma__set_ring_base,"ax",@progbits
	.global hwd_dma__set_ring_base
hwd_dma__set_ring_base:
	.global L_8cd5dc
L_8cd5dc:
	push_s blink
L_8cd5de:
	bl.d L_8c02c0
L_8cd5e2:
	mov_s r6,r2
L_8cd5e4:
	mov_s r14,r3
L_8cd5e6:
	mov_s r15,r4
L_8cd5e8:
	cmp r5,0x0
L_8cd5ec:
	mul64 r0,0x380
L_8cd5f0:
	mov_s r13,mlo
L_8cd5f2:
	add r0,r13,0x4409940
L_8cd5fa:
	lsr_s r0,r0,0x3
L_8cd5fc:
	bic r0,r0,0x3
L_8cd600:
	st_s r1,[r0]
L_8cd602:
	bl.ne.d L_8c7e64
L_8cd606:
	mov.ne r0,r6
L_8cd60a:
	add r0,r13,0x4409720
L_8cd612:
	lsr_s r0,r0,0x3
L_8cd614:
	bic r0,r0,0x3
L_8cd618:
	st_s r14,[r0]
L_8cd61a:
	add_s r13,r13,0x4409740
L_8cd620:
	lsr_s r13,r13,0x3
L_8cd622:
	bic r13,r13,0x3
L_8cd626:
	st_s r15,[r13]
L_8cd628:
	b L_8c032c
