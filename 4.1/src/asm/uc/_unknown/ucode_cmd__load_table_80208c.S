/* ucode_cmd__load_table_80208c @ 0x921740, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x23_handler
 */
	.section .text.ucode_cmd__load_table_80208c,"ax",@progbits
	.global ucode_cmd__load_table_80208c
ucode_cmd__load_table_80208c:
	.global L_921740
L_921740:
	b.d L_921748
L_921744:
	add_s r0,r0,0x8
L_921746:
	nop_s
	.global L_921748
L_921748:
	ld r11,[r1]
L_92174c:
	mov_s r2,0x80208c
L_921752:
	ld r10,[r1, 0x4]
L_921756:
	mov_s r0,0x0
L_921758:
	ld r9,[r1, 0x8]
L_92175c:
	st r11,[r2, 0x4]
L_921760:
	st r10,[r2, 0x8]
L_921764:
	st r9,[r2, 0xc]
L_921768:
	j.d [blink]
L_92176c:
	stw_s r0,[r2]
L_92176e:
	nop_s
