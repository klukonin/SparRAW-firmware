/* mac_parser__rule_b @ 0x8dfde4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__init
 * Зовёт сам: mac_parser__uses_rgf_886280
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser__rule_b
mac_parser__rule_b:
	.global L_8dfde4
L_8dfde4:
	push_s blink
L_8dfde6:
	mov_s r1,r0
L_8dfde8:
	mov r0,0x403
L_8dfdec:
	stw.a r0,[sp,-0x8]
L_8dfdf0:
	mov_s r0,sp
L_8dfdf2:
	stw 0xd480,[sp, 0x2]
L_8dfdfa:
	asl_s r1,r1,0x12
L_8dfdfc:
	or r1,r1,0x801f7f
L_8dfe04:
	st_s r1,[sp,0x4]
L_8dfe06:
	mov_s r1,0x0
L_8dfe08:
	bl.d L_8dfbd8
L_8dfe0c:
	mov_s r2,0x3
L_8dfe0e:
	add_s sp,sp,0x8
L_8dfe10:
	pop_s blink
L_8dfe12:
	j_s [blink]
