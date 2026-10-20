/* mac__reset_882680 @ 0x8ce464, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SYSTEM
 * Зовут его: WBE_DRIVER__pcie_boot_init
 */
	.section .text.mac__reset_882680,"ax",@progbits
	.global mac__reset_882680
mac__reset_882680:
	.global L_8ce464
L_8ce464:
	mov_s r0,0x882680
L_8ce46a:
	st 0x1000000,[r0, 0x4]
L_8ce472:
	j_s [blink]
