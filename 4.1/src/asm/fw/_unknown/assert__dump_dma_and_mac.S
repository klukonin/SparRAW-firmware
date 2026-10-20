/* assert__dump_dma_and_mac @ 0x8e3604, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: tail_hwd_dma__kick_channel_8cdf9c, tail_pcie__set_event_bit_8cee58
 */
	.section .text.assert__dump_dma_and_mac,"ax",@progbits
	.global assert__dump_dma_and_mac
assert__dump_dma_and_mac:
	.global L_8e3604
L_8e3604:
	push_s blink
L_8e3606:
	bl L_8cdf9c
L_8e360a:
	bl L_8cee58
L_8e360e:
	pop_s blink
L_8e3610:
	j_s [blink]
L_8e3612:
	nop_s
