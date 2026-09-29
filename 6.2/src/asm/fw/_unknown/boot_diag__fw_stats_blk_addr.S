/* boot_diag__fw_stats_blk_addr @ 0x8cc160, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__install_diag_magic
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot_diag__fw_stats_blk_addr
boot_diag__fw_stats_blk_addr:
	.global L_8cc160
L_8cc160:
	mov_s r0,0x853800
L_8cc166:
	j_s [blink]
