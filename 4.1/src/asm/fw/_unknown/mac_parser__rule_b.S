/* mac_parser__rule_b @ 0x8dbd14, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__init
 * Зовёт сам: mac_parser__write_rule
 */
	.section .text.mac_parser__rule_b,"ax",@progbits
	.global mac_parser__rule_b
mac_parser__rule_b:
	.global L_8dbd14
L_8dbd14:
	push_s blink
L_8dbd16:
	mov_s r1,r0
L_8dbd18:
	mov r0,0x403
L_8dbd1c:
	stw.a r0,[sp,-0x8]
L_8dbd20:
	mov_s r0,sp
L_8dbd22:
	stw 0xd480,[sp, 0x2]
L_8dbd2a:
	asl_s r1,r1,0x12
L_8dbd2c:
	or r1,r1,0x801f7f
L_8dbd34:
	st_s r1,[sp,0x4]
L_8dbd36:
	mov_s r1,0x0
L_8dbd38:
	bl.d L_8dbb00
L_8dbd3c:
	mov_s r2,0x3
L_8dbd3e:
	add_s sp,sp,0x8
L_8dbd40:
	pop_s blink
L_8dbd42:
	j_s [blink]
