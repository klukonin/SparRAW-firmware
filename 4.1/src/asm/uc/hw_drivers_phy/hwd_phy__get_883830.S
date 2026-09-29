/* hwd_phy__get_883830 @ 0x927470, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__latch_phy_883830
 */
	.section .text.hwd_phy__get_883830,"ax",@progbits
	.global hwd_phy__get_883830
hwd_phy__get_883830:
	.global L_927470
L_927470:
	ld r0,[0x883830]
L_927478:
	lsr_s r0,r0,0xe
L_92747a:
	j_s.d [blink]
L_92747c:
	bmsk_s r0,r0,0x6
L_92747e:
	nop_s
