/* mac_rx_cnt__get_mcs0_crc_err @ 0x8dd77c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__report
 * Глобалы (через gp): 0x8003d0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_rx_cnt__get_mcs0_crc_err
mac_rx_cnt__get_mcs0_crc_err:
	.global L_8dd77c
L_8dd77c:
	ld_s r0,[gp,0x24c]
L_8dd77e:
	ld_s r0,[r0,0x10]
L_8dd780:
	j_s [blink]
L_8dd782:
	nop_s
