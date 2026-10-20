/* hwd_dma__enable_ring_bits @ 0x8cd924, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__configure_ring
 */
	.section .text.hwd_dma__enable_ring_bits,"ax",@progbits
	.global hwd_dma__enable_ring_bits
hwd_dma__enable_ring_bits:
	.global L_8cd924
L_8cd924:
	push_s blink
L_8cd926:
	mul64 r0,0x380
L_8cd92a:
	add r1,mlo,0x44096c0
L_8cd932:
	lsr r2,r1,0x3
L_8cd936:
	bic r3,r2,0x3
L_8cd93a:
	ld_s r3,[r3]
L_8cd93c:
	bmsk_s r1,r1,0x4
L_8cd93e:
	bset r3,r3,r1
L_8cd942:
	add r1,mlo,0x44096c1
L_8cd94a:
	bmsk_s r1,r1,0x4
L_8cd94c:
	bset r3,r3,r1
L_8cd950:
	add r1,mlo,0x44096c2
L_8cd958:
	add r0,mlo,0x44096c3
L_8cd960:
	bmsk_s r1,r1,0x4
L_8cd962:
	bset r3,r3,r1
L_8cd966:
	bmsk_s r0,r0,0x4
L_8cd968:
	bset r3,r3,r0
L_8cd96c:
	st_s r3,[r2]
L_8cd96e:
	sync
L_8cd972:
	pop_s blink
L_8cd974:
	j_s [blink]
L_8cd976:
	nop_s
