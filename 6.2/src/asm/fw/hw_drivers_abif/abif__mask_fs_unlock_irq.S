/* abif__mask_fs_unlock_irq @ 0x8d00e8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_abif__fs_off
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global abif__mask_fs_unlock_irq
abif__mask_fs_unlock_irq:
	.global L_8d00e8
L_8d00e8:
	mov_s r1,0x80
L_8d00ea:
	mov_s r0,0x889480
L_8d00f0:
	st_s r1,[r0]
L_8d00f2:
	j_s [blink]
