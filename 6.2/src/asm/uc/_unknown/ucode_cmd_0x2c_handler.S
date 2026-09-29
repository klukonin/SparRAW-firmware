/* ucode_cmd_0x2c_handler @ 0x9373fc, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: tof__set_tx_rx_offset_regs, tof__store_tx_rx_offset
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x2c_handler
ucode_cmd_0x2c_handler:
	.global L_9373fc
L_9373fc:
	push_s blink
L_9373fe:
	ld_s r1,[r0,0x4]
L_937400:
	bl.d L_937420
L_937404:
	ld_s r0,[r0]
L_937406:
	mov_s r0,0x800694
L_93740c:
	ld_s r0,[r0]
L_93740e:
	mov_s r1,0x800698
L_937414:
	bl.d L_929d10
L_937418:
	ld_s r1,[r1]
L_93741a:
	pop_s blink
L_93741c:
	j_s [blink]
L_93741e:
	nop_s
