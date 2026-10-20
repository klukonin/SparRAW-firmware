/* mid__copy_mac_addr @ 0x8c75b0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__lookup_for_tx
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__copy_mac_addr
mid__copy_mac_addr:
	.global L_8c75b0
L_8c75b0:
	mov_s r2,r0
L_8c75b2:
	mov_s r0,r1
L_8c75b4:
	add r1,r2,0x1c
L_8c75b8:
	b.d L_8c0380
L_8c75bc:
	mov_s r2,0x6
L_8c75be:
	nop_s
