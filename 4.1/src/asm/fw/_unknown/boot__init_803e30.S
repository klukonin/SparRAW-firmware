/* boot__init_803e30 @ 0x8c1884, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, obj__store3_wrap
 */
	.section .text.boot__init_803e30,"ax",@progbits
	.global boot__init_803e30
boot__init_803e30:
L_8c1884:
	push_s blink
L_8c1886:
	push_s r13
L_8c1888:
	mov_s r13,0x803e30
L_8c188e:
	mov_s r2,0x800b44
L_8c1894:
	mov_s r3,0x800c04
L_8c189a:
	mov_s r0,r13
L_8c189c:
	mov_s r1,0x0
L_8c189e:
	bl.d L_8c176c
L_8c18a2:
	mov r4,0x30
L_8c18a6:
	mov_s r0,0x800710
L_8c18ac:
	b.d L_8c033c
