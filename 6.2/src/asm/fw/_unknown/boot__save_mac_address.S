/* boot__save_mac_address @ 0x8e68f0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__load_from_flash
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot__save_mac_address
boot__save_mac_address:
	.global L_8e68f0
L_8e68f0:
	mov_s r1,r0
L_8e68f2:
	mov_s r0,0x8004a4
L_8e68f8:
	b.d L_8c0380
L_8e68fc:
	mov_s r2,0x6
L_8e68fe:
	nop_s
