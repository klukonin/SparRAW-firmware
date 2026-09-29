/* otp__write_word @ 0x8f3aa4, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   write  0x%x to 0x%x
 * Зовут его: otp__write_bytes
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit2, marlon_r_if__otp_write
 */
	.section .text.otp__write_word,"ax",@progbits
	.global otp__write_word
otp__write_word:
	.global L_8f3aa4
L_8f3aa4:
	push_s blink
L_8f3aa6:
	bl L_8c02b4
L_8f3aaa:
	mov_s r18,r0
L_8f3aac:
	mov_s r17,r1
L_8f3aae:
	mov_s r14,r2
L_8f3ab0:
	mov_s r16,r3
L_8f3ab2:
	mov_s r2,0x100530c
L_8f3ab8:
	mov_s r13,0x0
L_8f3aba:
	mov_s r0,r13
L_8f3abc:
	mov_s r1,0x2
L_8f3abe:
	mov_s r3,r14
L_8f3ac0:
	bl.d L_8edff8
L_8f3ac4:
	mov r4,r16
L_8f3ac8:
	mov_s r15,0x8
	.global L_8f3aca
L_8f3aca:
	add_s r2,r13,r14
L_8f3acc:
	extw_s r2,r2
L_8f3ace:
	mov_s r0,r18
L_8f3ad0:
	mov_s r1,r17
L_8f3ad2:
	bl.d L_8f3b00
L_8f3ad6:
	bmsk r3,r16,0x0
L_8f3ada:
	asr r0,r16
L_8f3ade:
	extb r16,r0
L_8f3ae2:
	mov r0,0x640
L_8f3ae6:
	mov lp_count,r0
L_8f3aea:
	nop_s
L_8f3aec:
	lp L_8f3af4
L_8f3af0:
	nop_s
L_8f3af2:
	nop_s
	.global L_8f3af4
L_8f3af4:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8f3af6:
	/* brhs.d r15,0x1,0x008f3aca */
	.byte 0xd7,0x0f,0x75,0x90
L_8f3afa:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8f3afc:
	b L_8c0314
