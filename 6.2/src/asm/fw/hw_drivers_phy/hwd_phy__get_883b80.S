/* hwd_phy__get_883b80 @ 0x8d2cf4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery_handle_probe_resp
 * Зовёт сам: bits__sign_extend_n
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__get_883b80
hwd_phy__get_883b80:
	.global L_8d2cf4
L_8d2cf4:
	push_s blink
L_8d2cf6:
	mov_s r0,0x883b80
L_8d2cfc:
	ld_s r0,[r0,0x6c]
L_8d2cfe:
	lsr_s r0,r0,0xa
L_8d2d00:
	bmsk_s r0,r0,0xa
L_8d2d02:
	bl.d L_8ea8c0
L_8d2d06:
	mov_s r1,0xb
L_8d2d08:
	sexw_s r0,r0
L_8d2d0a:
	pop_s blink
L_8d2d0c:
	j_s [blink]
L_8d2d0e:
	nop_s
