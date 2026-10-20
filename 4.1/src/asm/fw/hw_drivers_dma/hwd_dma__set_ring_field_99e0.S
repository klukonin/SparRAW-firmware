/* hwd_dma__set_ring_field_99e0 @ 0x8cdd24, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_dma.c
 * Зовут его: dma_mgr__configure_ring, sw_vring__ba_agreed
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_dma__set_ring_field_99e0,"ax",@progbits
	.global hwd_dma__set_ring_field_99e0
hwd_dma__set_ring_field_99e0:
	.global L_8cdd24
L_8cdd24:
	push_s blink
L_8cdd26:
	bl L_8c02c0
L_8cdd2a:
	mov_s r14,r0
L_8cdd2c:
	and.f 0x0,r1,0xffff0000
L_8cdd34:
	mov_s r13,r1
L_8cdd36:
	bne_s L_8cdd72
	.global L_8cdd38
L_8cdd38:
	mul64 r14,0x380
L_8cdd3c:
	mov_s r3,0x0
L_8cdd3e:
	mov_s r15,0x0
L_8cdd40:
	add r0,mlo,0x44099e0
L_8cdd48:
	lsr r1,r0,0x3
L_8cdd4c:
	bmsk_s r0,r0,0x4
L_8cdd4e:
	add r14,r0,0xf
L_8cdd52:
	bset r3,r3,r14
L_8cdd56:
	bic r2,r1,0x3
L_8cdd5a:
	ld_s r1,[r2]
L_8cdd5c:
	bset r15,r15,r0
L_8cdd60:
	sub r14,r3,r15
L_8cdd64:
	or_s r3,r3,r14
L_8cdd66:
	asl_s r13,r13,r0
L_8cdd68:
	bic_s r1,r1,r3
L_8cdd6a:
	or_s r13,r13,r1
L_8cdd6c:
	st_s r13,[r2]
L_8cdd6e:
	b L_8c032c
	.global L_8cdd72
L_8cdd72:
	mov_s r0,blink
L_8cdd74:
	mov_s r2,0x1018504
L_8cdd7a:
	mov_s r1,0xac
L_8cdd7c:
	bl.d L_8c82c0
L_8cdd80:
	mov_s r3,0xc6
L_8cdd82:
	b_s L_8cdd38
