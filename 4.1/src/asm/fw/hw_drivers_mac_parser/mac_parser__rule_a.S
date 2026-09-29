/* mac_parser__rule_a @ 0x8dba64, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_parser__write_rule, memset0_words
 */
	.section .text.mac_parser__rule_a,"ax",@progbits
	.global mac_parser__rule_a
mac_parser__rule_a:
	.global L_8dba64
L_8dba64:
	push_s blink
L_8dba66:
	bl.d L_8c02c4
L_8dba6a:
	mov_s r1,0x8
L_8dba6c:
	sub_s sp,sp,0x8
L_8dba6e:
	bl.d L_8c1a78
L_8dba72:
	mov_s r0,sp
L_8dba74:
	mov_s r14,0x0
L_8dba76:
	mov_s r13,0x40
	.global L_8dba78
L_8dba78:
	mov_s r0,sp
L_8dba7a:
	mov_s r1,r14
L_8dba7c:
	bl.d L_8dbb00
L_8dba80:
	mov_s r2,0x3
L_8dba82:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8dba84:
	/* brhs.d r13,0x1,0x008dba78 */
	.byte 0xf5,0x0d,0x75,0x90
L_8dba88:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8dba8a:
	b.d L_8c0334
L_8dba8e:
	add_s sp,sp,0x8
