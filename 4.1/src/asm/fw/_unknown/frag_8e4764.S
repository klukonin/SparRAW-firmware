/* frag_8e4764 @ 0x8e4764, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: tail_hwd_dma__kick_channel, tail_pcie__set_event_bit
 */
	.section .text.frag_8e4764,"ax",@progbits
	.global frag_8e4764
frag_8e4764:
L_8e4764:
	j_s [blink]
	.global sub_8e4766
sub_8e4766:
L_8e4766:
	nop_s
L_8e4768:
	push_s blink
L_8e476a:
	bl L_8cee48
L_8e476e:
	bl L_8cdf8c
L_8e4772:
	pop_s blink
