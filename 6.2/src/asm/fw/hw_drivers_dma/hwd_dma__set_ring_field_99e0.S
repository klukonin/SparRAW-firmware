/* hwd_dma__set_ring_field_99e0 @ 0x8d0a80, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__configure_ring, sw_vring__ba_agreed
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__set_ring_field_99e0
hwd_dma__set_ring_field_99e0:
	.global L_8d0a80
L_8d0a80:
	push_s blink
L_8d0a82:
	bl L_8c01e0
L_8d0a86:
	mov_s r14,r0
L_8d0a88:
	and.f 0x0,r1,0xffff0000
L_8d0a90:
	mov_s r13,r1
L_8d0a92:
	bne_s L_8d0ace
	.global L_8d0a94
L_8d0a94:
	mul64 r14,0x380
L_8d0a98:
	mov_s r3,0x0
L_8d0a9a:
	mov_s r15,0x0
L_8d0a9c:
	add r0,mlo,0x44099e0
L_8d0aa4:
	lsr r1,r0,0x3
L_8d0aa8:
	bmsk_s r0,r0,0x4
L_8d0aaa:
	add r14,r0,0xf
L_8d0aae:
	bset r3,r3,r14
L_8d0ab2:
	bic r2,r1,0x3
L_8d0ab6:
	ld_s r1,[r2]
L_8d0ab8:
	bset r15,r15,r0
L_8d0abc:
	sub r14,r3,r15
L_8d0ac0:
	or_s r3,r3,r14
L_8d0ac2:
	asl_s r13,r13,r0
L_8d0ac4:
	bic_s r1,r1,r3
L_8d0ac6:
	or_s r13,r13,r1
L_8d0ac8:
	st_s r13,[r2]
L_8d0aca:
	b L_8c024c
	.global L_8d0ace
L_8d0ace:
	mov_s r0,blink
L_8d0ad0:
	bl.d L_8c9b28
L_8d0ad4:
	mov_s r1,0xac
L_8d0ad6:
	b_s L_8d0a94
