/* pcie_irq__extract_bit_by_code @ 0x8ce788, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_pcie_main
 */
	.section .text.pcie_irq__extract_bit_by_code,"ax",@progbits
	.global pcie_irq__extract_bit_by_code
pcie_irq__extract_bit_by_code:
	.global L_8ce788
L_8ce788:
	brhs r1,0xa,L_8ce7d2
L_8ce78c:
	ldb.x r1,[0x8030a4,r1]
L_8ce794:
	add r2,pcl,0x8
L_8ce798:
	add1_s r2,r2,r1
L_8ce79a:
	j_s [r2]
L_8ce79c:
	lsr_s r0,r0,0xb
L_8ce79e:
	j_s.d [blink]
L_8ce7a0:
	bmsk_s r0,r0,0x0
L_8ce7a2:
	lsr_s r0,r0,0xd
L_8ce7a4:
	j_s.d [blink]
L_8ce7a6:
	bmsk_s r0,r0,0x0
L_8ce7a8:
	lsr_s r0,r0,0xe
L_8ce7aa:
	j_s.d [blink]
L_8ce7ac:
	bmsk_s r0,r0,0x0
L_8ce7ae:
	lsr_s r0,r0,0x3
L_8ce7b0:
	j_s.d [blink]
L_8ce7b2:
	bmsk_s r0,r0,0x0
L_8ce7b4:
	lsr_s r0,r0,0x12
L_8ce7b6:
	j_s.d [blink]
L_8ce7b8:
	bmsk_s r0,r0,0x0
L_8ce7ba:
	lsr_s r0,r0,0x5
L_8ce7bc:
	j_s.d [blink]
L_8ce7be:
	bmsk_s r0,r0,0x0
L_8ce7c0:
	lsr_s r0,r0,0x4
L_8ce7c2:
	j_s.d [blink]
L_8ce7c4:
	bmsk_s r0,r0,0x0
L_8ce7c6:
	lsr_s r0,r0,0x1d
L_8ce7c8:
	j_s.d [blink]
L_8ce7ca:
	bmsk_s r0,r0,0x0
L_8ce7cc:
	lsr_s r0,r0,0x18
L_8ce7ce:
	j_s.d [blink]
L_8ce7d0:
	bmsk_s r0,r0,0x0
	.global L_8ce7d2
L_8ce7d2:
	mov_s r0,0x0
L_8ce7d4:
	j_s [blink]
L_8ce7d6:
	nop_s
