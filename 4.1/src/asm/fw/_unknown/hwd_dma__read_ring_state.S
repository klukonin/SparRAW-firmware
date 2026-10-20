/* hwd_dma__read_ring_state @ 0x8d1644, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__notify_delete
 */
	.section .text.hwd_dma__read_ring_state,"ax",@progbits
	.global hwd_dma__read_ring_state
hwd_dma__read_ring_state:
	.global L_8d1644
L_8d1644:
	mul64 r1,0x380
L_8d1648:
	add r2,mlo,0x44098c0
L_8d1650:
	lsr r1,r2,0x3
L_8d1654:
	bic r1,r1,0x3
L_8d1658:
	ld_s r1,[r1]
L_8d165a:
	bmsk_s r2,r2,0x4
L_8d165c:
	lsr_s r1,r1,r2
L_8d165e:
	extw_s r2,r1
L_8d1660:
	asl r1,r0,0x8
L_8d1664:
	add r0,r1,0x440c140
L_8d166c:
	bmsk r3,r0,0x4
L_8d1670:
	lsr_s r0,r0,0x3
L_8d1672:
	asl_s r2,r2,r3
L_8d1674:
	add_s r1,r1,0x440c15f
L_8d167a:
	bic r0,r0,0x3
L_8d167e:
	st_s r2,[r0]
L_8d1680:
	bmsk_s r1,r1,0x4
L_8d1682:
	bset r2,r2,r1
L_8d1686:
	st_s r2,[r0]
L_8d1688:
	j_s [blink]
L_8d168a:
	nop_s
