/* install_key_handle @ 0x8f5a5c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: low_sme__send_evt2sw, return_field_type
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, conn__sec_mode_not_1, vring__reinstall_keys_for_mid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global install_key_handle
install_key_handle:
	.global L_8f5a5c
L_8f5a5c:
	push_s blink
L_8f5a5e:
	push_s r13
L_8f5a60:
	mov_s r13,r0
L_8f5a62:
	add r0,r0,0x124
L_8f5a66:
	mov_s r1,0x7
L_8f5a68:
	mov_s r2,0x0
L_8f5a6a:
	mov_s r3,r2
L_8f5a6c:
	bl.d L_8d9b6c
L_8f5a70:
	mov_s r4,r2
L_8f5a72:
	bl.d L_8da5f8
L_8f5a76:
	mov_s r0,r13
L_8f5a78:
	mov_s r1,r0
L_8f5a7a:
	bl.d L_8ea7ac
L_8f5a7e:
	mov_s r0,r13
L_8f5a80:
	b L_8c025c
