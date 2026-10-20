/* mid__copy_addr @ 0x8ea984, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__lookup_for_tx
 * Зовёт сам: memcpy_fw
 */
	.section .text.mid__copy_addr,"ax",@progbits
	.global mid__copy_addr
mid__copy_addr:
	.global L_8ea984
L_8ea984:
	mov_s r2,r0
L_8ea986:
	mov_s r0,r1
L_8ea988:
	add r1,r2,0x10
L_8ea98c:
	b.d L_8c0460
L_8ea990:
	mov_s r2,0x6
L_8ea992:
	nop_s
