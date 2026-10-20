/* txrx_mgr__handle_dma_irq @ 0x8c7de0, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txrx_manager.cpp
 * Зовут его: isr_txrx_manager
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, hwd_dma__get_881c00, hwd_dma__set_881c00_8cddf0, u_schd__add, vring_hw__read_status_bit
 * Глобалы (через gp): 0x800328
 */
	.section .text.txrx_mgr__handle_dma_irq,"ax",@progbits
	.global txrx_mgr__handle_dma_irq
txrx_mgr__handle_dma_irq:
	.global L_8c7de0
L_8c7de0:
	push_s blink
L_8c7de2:
	bl L_8c02c0
L_8c7de6:
	bl L_8cda28
L_8c7dea:
	ld.as r1,[gp,0x6e]
L_8c7dee:
	bmsk r15,r0,0xb
L_8c7df2:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c7df4:
	st.as r1,[gp,0x6e]
L_8c7df8:
	lsr r1,r0,0xc
L_8c7dfc:
	bmsk_s r1,r1,0xb
L_8c7dfe:
	and.f 0x0,r0,0xf0000000
L_8c7e06:
	cmp.eq r1,0x0
L_8c7e0a:
	bne_s L_8c7e40
	.global L_8c7e0c
L_8c7e0c:
	mov_s r14,r15
L_8c7e0e:
	b_s L_8c7e24
	.global L_8c7e10
L_8c7e10:
	mov_s r0,0x24ba0
	.global L_8c7e16
L_8c7e16:
	mov_s r1,r13
L_8c7e18:
	mov_s r2,0x0
L_8c7e1a:
	bl.d L_8c2ac8
L_8c7e1e:
	mov_s r3,0x1
L_8c7e20:
	bclr r14,r14,r13
	.global L_8c7e24
L_8c7e24:
	breq_s r14,0,L_8c7e56
L_8c7e26:
	norm r0,r14
L_8c7e2a:
	rsub r13,r0,0x1e
L_8c7e2e:
	bl.d L_8cd9ec
L_8c7e32:
	mov_s r0,r13
L_8c7e34:
	brne r0,0x1,L_8c7e10
L_8c7e38:
	mov_s r0,0x1ee30
L_8c7e3e:
	b_s L_8c7e16
	.global L_8c7e40
L_8c7e40:
	mov_s r0,blink
L_8c7e42:
	mov_s r2,0x100a570
L_8c7e48:
	mov_s r1,0x1207
L_8c7e4e:
	bl.d L_8c82c0
L_8c7e52:
	mov_s r3,0x49
L_8c7e54:
	b_s L_8c7e0c
	.global L_8c7e56
L_8c7e56:
	mov_s r0,r15
L_8c7e58:
	bl.d L_8cddf0
L_8c7e5c:
	mov_s r1,0x1
L_8c7e5e:
	b L_8c032c
L_8c7e62:
	nop_s
