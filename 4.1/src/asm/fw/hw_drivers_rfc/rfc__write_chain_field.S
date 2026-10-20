/* rfc__write_chain_field @ 0x8d0d9c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__configure_chain
 * Зовёт сам: __ld_r13_ret, rfc_field_write
 */
	.section .text.rfc__write_chain_field,"ax",@progbits
	.global rfc__write_chain_field
rfc__write_chain_field:
	.global L_8d0d9c
L_8d0d9c:
	push_s blink
L_8d0d9e:
	push_s r13
L_8d0da0:
	bmsk_s r1,r1,0x0
L_8d0da2:
	asl_s r2,r2
L_8d0da4:
	and r13,r2,0x2
L_8d0da8:
	bclr_s r1,r1,0x1
L_8d0daa:
	or_s r13,r13,r1
L_8d0dac:
	/* asl_s r3,r3,0x2 */
	.byte 0x02,0xbb
L_8d0dae:
	and r2,r3,0x4
L_8d0db2:
	bclr_s r13,r13,0x2
L_8d0db4:
	mov r1,0x4cc
L_8d0db8:
	bl.d L_8d113c
L_8d0dbc:
	or_s r2,r2,r13
L_8d0dbe:
	b L_8c033c
L_8d0dc2:
	nop_s
