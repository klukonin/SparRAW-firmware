/* rx_queue__set_type_bits @ 0x8df704, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.rx_queue__set_type_bits,"ax",@progbits
	.global rx_queue__set_type_bits
rx_queue__set_type_bits:
L_8df704:
	bclr_s r0,r0,0x17
L_8df706:
	bclr_s r0,r0,0x18
L_8df708:
	bclr_s r0,r0,0x19
L_8df70a:
	bset_s r0,r0,0x17
L_8df70c:
	bset_s r0,r0,0x18
L_8df70e:
	/* b_s 0x008df6b4 */
	.byte 0xd4,0xf1
