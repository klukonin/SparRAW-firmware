/* tof__store_tx_rx_offset @ 0x937420, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x2c_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tof__store_tx_rx_offset
tof__store_tx_rx_offset:
	.global L_937420
L_937420:
	mov_s r2,0x800694
L_937426:
	st_s r0,[r2]
L_937428:
	j.d [blink]
L_93742c:
	st_s r1,[r2,0x4]
L_93742e:
	nop_s
