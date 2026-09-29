/* hwd_dma__set_ring_field_9a10 @ 0x8d0c48, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__configure_ring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__set_ring_field_9a10
hwd_dma__set_ring_field_9a10:
	.global L_8d0c48
L_8d0c48:
	push_s blink
L_8d0c4a:
	bl L_8c01e0
L_8d0c4e:
	mov_s r13,r1
L_8d0c50:
	bic.f r1,r1,0xf
L_8d0c54:
	mov_s r14,r0
L_8d0c56:
	bne_s L_8d0c90
	.global L_8d0c58
L_8d0c58:
	mul64 r14,0x380
L_8d0c5c:
	mov_s r3,0x0
L_8d0c5e:
	mov_s r15,0x0
L_8d0c60:
	add r0,mlo,0x4409a10
L_8d0c68:
	lsr r1,r0,0x3
L_8d0c6c:
	bmsk_s r0,r0,0x4
L_8d0c6e:
	add_s r14,r0,0x3
L_8d0c70:
	bset r3,r3,r14
L_8d0c74:
	bic r2,r1,0x3
L_8d0c78:
	ld_s r1,[r2]
L_8d0c7a:
	bset r15,r15,r0
L_8d0c7e:
	sub r14,r3,r15
L_8d0c82:
	or_s r3,r3,r14
L_8d0c84:
	asl_s r13,r13,r0
L_8d0c86:
	bic_s r1,r1,r3
L_8d0c88:
	or_s r13,r13,r1
L_8d0c8a:
	st_s r13,[r2]
L_8d0c8c:
	b L_8c024c
	.global L_8d0c90
L_8d0c90:
	mov_s r0,blink
L_8d0c92:
	bl.d L_8c9b28
L_8d0c96:
	mov_s r1,0xac
L_8d0c98:
	b_s L_8d0c58
L_8d0c9a:
	nop_s
