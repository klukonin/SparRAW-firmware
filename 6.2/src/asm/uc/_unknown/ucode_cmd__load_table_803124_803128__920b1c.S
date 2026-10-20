/* ucode_cmd__load_table_803124_803128__920b1c @ 0x920b1c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x23_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd__load_table_803124_803128__920b1c
ucode_cmd__load_table_803124_803128__920b1c:
	.global L_920b1c
L_920b1c:
	b.d L_920b24
L_920b20:
	add_s r0,r0,0x8
L_920b22:
	nop_s
	.global L_920b24
L_920b24:
	ld r11,[r1]
L_920b28:
	mov_s r2,0x803124
L_920b2e:
	ld r10,[r1, 0x4]
L_920b32:
	mov_s r0,0x0
L_920b34:
	ld r9,[r1, 0x8]
L_920b38:
	st r11,[r2, 0x4]
L_920b3c:
	st r10,[r2, 0x8]
L_920b40:
	st r9,[r2, 0xc]
L_920b44:
	j.d [blink]
L_920b48:
	stw_s r0,[r2]
L_920b4a:
	nop_s
