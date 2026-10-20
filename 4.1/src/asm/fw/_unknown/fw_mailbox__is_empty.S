/* fw_mailbox__is_empty @ 0x8d7078, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_mailbox__has_pending, fw_mailbox__write
 */
	.section .text.fw_mailbox__is_empty,"ax",@progbits
	.global fw_mailbox__is_empty
fw_mailbox__is_empty:
	.global L_8d7078
L_8d7078:
	ld_s r0,[r0]
L_8d707a:
	ld_s r0,[r0]
L_8d707c:
	cmp_s r0,0x0
L_8d707e:
	mov_s r0,0x1
L_8d7080:
	j_s.d [blink]
L_8d7082:
	sub_s.ne r0,r0,r0
