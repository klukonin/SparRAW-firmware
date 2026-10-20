/* phy__get_885178_3bit @ 0x8d1b88, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: channel_estimation_cmd_start, hwd_phy_rx_read_and_parse_brp_ram
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy__get_885178_3bit
phy__get_885178_3bit:
	.global L_8d1b88
L_8d1b88:
	mov_s r0,0x885100
L_8d1b8e:
	ld_s r0,[r0,0x78]
L_8d1b90:
	j_s.d [blink]
L_8d1b92:
	bmsk_s r0,r0,0x2
