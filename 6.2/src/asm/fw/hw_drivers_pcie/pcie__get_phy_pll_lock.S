/* pcie__get_phy_pll_lock @ 0x8d1434, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_16
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__get_phy_pll_lock
pcie__get_phy_pll_lock:
	.global L_8d1434
L_8d1434:
	mov_s r0,0x882600
L_8d143a:
	ld_s r0,[r0,0x2c]
L_8d143c:
	lsr_s r0,r0,0xb
L_8d143e:
	j_s.d [blink]
L_8d1440:
	bmsk_s r0,r0,0x0
L_8d1442:
	nop_s
