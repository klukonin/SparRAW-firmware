/* fw_mailbox__is_empty @ 0x8da150, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_mailbox__has_pending, wmi_evt__fill_payload
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_mailbox__is_empty
fw_mailbox__is_empty:
	.global L_8da150
L_8da150:
	ld_s r0,[r0]
L_8da152:
	ld_s r0,[r0]
L_8da154:
	cmp_s r0,0x0
L_8da156:
	mov_s r0,0x1
L_8da158:
	j_s.d [blink]
L_8da15a:
	sub_s.ne r0,r0,r0
