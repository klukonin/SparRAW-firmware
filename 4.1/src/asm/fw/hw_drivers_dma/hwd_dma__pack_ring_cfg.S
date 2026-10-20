/* hwd_dma__pack_ring_cfg @ 0x8cdcac, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__configure_ring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.hwd_dma__pack_ring_cfg,"ax",@progbits
	.global hwd_dma__pack_ring_cfg
hwd_dma__pack_ring_cfg:
	.global L_8cdcac
L_8cdcac:
	push_s blink
L_8cdcae:
	bl L_8c02c0
L_8cdcb2:
	mul64 r0,0x380
L_8cdcb6:
	add r15,mlo,0x44096e1
L_8cdcbe:
	bmsk_s r15,r15,0x4
L_8cdcc0:
	asl_s r1,r1,r15
L_8cdcc2:
	add r15,mlo,0x44096e2
L_8cdcca:
	bmsk_s r15,r15,0x4
L_8cdccc:
	asl_s r2,r2,r15
L_8cdcce:
	or_s r1,r1,r2
L_8cdcd0:
	add r2,mlo,0x44096e3
L_8cdcd8:
	bmsk_s r2,r2,0x4
L_8cdcda:
	asl_s r3,r3,r2
L_8cdcdc:
	or_s r3,r3,r1
L_8cdcde:
	add r1,mlo,0x44096e5
L_8cdce6:
	bmsk_s r1,r1,0x4
L_8cdce8:
	asl r14,r4,r1
L_8cdcec:
	add r1,mlo,0x44096e6
L_8cdcf4:
	bmsk_s r1,r1,0x4
L_8cdcf6:
	asl r13,r5,r1
L_8cdcfa:
	add r1,mlo,0x44096e4
L_8cdd02:
	or_s r14,r14,r3
L_8cdd04:
	bmsk_s r1,r1,0x4
L_8cdd06:
	asl r2,r6,r1
L_8cdd0a:
	add r0,mlo,0x44096e0
L_8cdd12:
	or_s r13,r13,r14
L_8cdd14:
	or_s r2,r2,r13
L_8cdd16:
	lsr_s r0,r0,0x3
L_8cdd18:
	st_s r2,[r0]
L_8cdd1a:
	sync
L_8cdd1e:
	b L_8c032c
L_8cdd22:
	nop_s
