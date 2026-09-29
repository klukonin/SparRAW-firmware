/* hwd_dma__set_ring_field_9a10 @ 0x8cdef4, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_dma.c
 * Зовут его: dma_mgr__configure_ring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_dma__set_ring_field_9a10,"ax",@progbits
	.global hwd_dma__set_ring_field_9a10
hwd_dma__set_ring_field_9a10:
	.global L_8cdef4
L_8cdef4:
	push_s blink
L_8cdef6:
	bl L_8c02c0
L_8cdefa:
	mov_s r13,r1
L_8cdefc:
	bic.f r1,r1,0xf
L_8cdf00:
	mov_s r14,r0
L_8cdf02:
	bne_s L_8cdf3c
	.global L_8cdf04
L_8cdf04:
	mul64 r14,0x380
L_8cdf08:
	mov_s r3,0x0
L_8cdf0a:
	mov_s r15,0x0
L_8cdf0c:
	add r0,mlo,0x4409a10
L_8cdf14:
	lsr r1,r0,0x3
L_8cdf18:
	bmsk_s r0,r0,0x4
L_8cdf1a:
	add_s r14,r0,0x3
L_8cdf1c:
	bset r3,r3,r14
L_8cdf20:
	bic r2,r1,0x3
L_8cdf24:
	ld_s r1,[r2]
L_8cdf26:
	bset r15,r15,r0
L_8cdf2a:
	sub r14,r3,r15
L_8cdf2e:
	or_s r3,r3,r14
L_8cdf30:
	asl_s r13,r13,r0
L_8cdf32:
	bic_s r1,r1,r3
L_8cdf34:
	or_s r13,r13,r1
L_8cdf36:
	st_s r13,[r2]
L_8cdf38:
	b L_8c032c
	.global L_8cdf3c
L_8cdf3c:
	mov_s r0,blink
L_8cdf3e:
	mov_s r2,0x1018504
L_8cdf44:
	mov_s r1,0xac
L_8cdf46:
	bl.d L_8c82c0
L_8cdf4a:
	mov_s r3,0xca
L_8cdf4c:
	b_s L_8cdf04
L_8cdf4e:
	nop_s
