/* pcie_irq__extract_bit_by_code_fw @ 0x8d1484, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_16
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_irq__extract_bit_by_code_fw
pcie_irq__extract_bit_by_code_fw:
	.global L_8d1484
L_8d1484:
	brhs r1,0xa,L_8d14ce
L_8d1488:
	ldb.x r1,[0x8038fc,r1]
L_8d1490:
	add r2,pcl,0x8
L_8d1494:
	add1_s r2,r2,r1
L_8d1496:
	j_s [r2]
L_8d1498:
	lsr_s r0,r0,0xb
L_8d149a:
	j_s.d [blink]
L_8d149c:
	bmsk_s r0,r0,0x0
L_8d149e:
	lsr_s r0,r0,0xd
L_8d14a0:
	j_s.d [blink]
L_8d14a2:
	bmsk_s r0,r0,0x0
L_8d14a4:
	lsr_s r0,r0,0xe
L_8d14a6:
	j_s.d [blink]
L_8d14a8:
	bmsk_s r0,r0,0x0
L_8d14aa:
	lsr_s r0,r0,0x3
L_8d14ac:
	j_s.d [blink]
L_8d14ae:
	bmsk_s r0,r0,0x0
L_8d14b0:
	lsr_s r0,r0,0x12
L_8d14b2:
	j_s.d [blink]
L_8d14b4:
	bmsk_s r0,r0,0x0
L_8d14b6:
	lsr_s r0,r0,0x5
L_8d14b8:
	j_s.d [blink]
L_8d14ba:
	bmsk_s r0,r0,0x0
L_8d14bc:
	lsr_s r0,r0,0x4
L_8d14be:
	j_s.d [blink]
L_8d14c0:
	bmsk_s r0,r0,0x0
L_8d14c2:
	lsr_s r0,r0,0x1d
L_8d14c4:
	j_s.d [blink]
L_8d14c6:
	bmsk_s r0,r0,0x0
L_8d14c8:
	lsr_s r0,r0,0x18
L_8d14ca:
	j_s.d [blink]
L_8d14cc:
	bmsk_s r0,r0,0x0
	.global L_8d14ce
L_8d14ce:
	mov_s r0,0x0
L_8d14d0:
	j_s [blink]
L_8d14d2:
	nop_s
