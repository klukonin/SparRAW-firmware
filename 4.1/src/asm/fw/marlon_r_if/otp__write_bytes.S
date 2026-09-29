/* otp__write_bytes @ 0x8f3a40, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   read size is outside of otp boundaries!
 *   byte number %d is %d
 * Зовут его: wmi_handler_otp_write
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit0, fw_log__emit2, otp__write_word
 */
	.section .text.otp__write_bytes,"ax",@progbits
	.global otp__write_bytes
otp__write_bytes:
	.global L_8f3a40
L_8f3a40:
	push_s blink
L_8f3a42:
	bl L_8c02b8
L_8f3a46:
	mov_s r16,r0
L_8f3a48:
	mov_s r17,r2
L_8f3a4a:
	add_s r2,r2,r3
L_8f3a4c:
	cmp_s r2,0x2000
L_8f3a52:
	mov_s r15,r4
L_8f3a54:
	bls_s L_8f3a68
L_8f3a56:
	mov_s r2,0x1005320
L_8f3a5c:
	mov_s r0,0x0
L_8f3a5e:
	bl.d L_8edfb0
L_8f3a62:
	mov_s r1,0x0
L_8f3a64:
	mov_s r0,0x0
L_8f3a66:
	b_s L_8f3aa0
	.global L_8f3a68
L_8f3a68:
	brlo.d r3,0x1,L_8f3a9e
L_8f3a6c:
	mov_s r14,0x0
L_8f3a6e:
	mov_s r13,r3
	.global L_8f3a70
L_8f3a70:
	mov_s r2,0x1005348
L_8f3a76:
	add_s r0,r15,r14
L_8f3a78:
	ldb r4,[r0]
L_8f3a7c:
	mov_s r0,0x0
L_8f3a7e:
	mov_s r1,r0
L_8f3a80:
	bl.d L_8edff8
L_8f3a84:
	mov_s r3,r14
L_8f3a86:
	add3 r2,r17,r14
L_8f3a8a:
	extw_s r2,r2
L_8f3a8c:
	ldb_s r3,[r15,r14]
L_8f3a8e:
	mov_s r0,r16
L_8f3a90:
	bl.d L_8f3aa4
L_8f3a94:
	mov_s r1,0x0
L_8f3a96:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8f3a98:
	/* brhs.d r13,0x1,0x008f3a70 */
	.byte 0xd9,0x0d,0x75,0x90
L_8f3a9c:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8f3a9e
L_8f3a9e:
	mov_s r0,0x1
	.global L_8f3aa0
L_8f3aa0:
	b L_8c031c
