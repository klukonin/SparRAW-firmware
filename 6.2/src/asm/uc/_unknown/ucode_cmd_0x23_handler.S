/* ucode_cmd_0x23_handler @ 0x920b4c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: ucode_cmd__load_table_803124_803128__920b1c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x23_handler
ucode_cmd_0x23_handler:
	.global L_920b4c
L_920b4c:
	mov_s r1,r0
L_920b4e:
	mov_s r0,0x802f44
L_920b54:
	b L_920b1c
