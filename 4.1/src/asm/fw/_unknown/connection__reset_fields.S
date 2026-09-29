/* connection__reset_fields @ 0x8d6244, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: connection__init
 * Зовёт сам: __ld_r13_ret, memset0_words
 */
	.section .text.connection__reset_fields,"ax",@progbits
	.global connection__reset_fields
connection__reset_fields:
	.global L_8d6244
L_8d6244:
	push_s blink
L_8d6246:
	push_s r13
L_8d6248:
	mov_s r13,r0
L_8d624a:
	st_s r1,[r0,0x4]
L_8d624c:
	mov_s r0,0x0
L_8d624e:
	st_s r0,[r13]
L_8d6250:
	st_s r0,[r13,0x48]
L_8d6252:
	st_s r0,[r13,0x8]
L_8d6254:
	add r0,r13,0xc
L_8d6258:
	bl.d L_8c1a78
L_8d625c:
	mov_s r1,0x20
L_8d625e:
	add r0,r13,0x2c
L_8d6262:
	bl.d L_8c1a78
L_8d6266:
	mov_s r1,0x10
L_8d6268:
	b L_8c033c
