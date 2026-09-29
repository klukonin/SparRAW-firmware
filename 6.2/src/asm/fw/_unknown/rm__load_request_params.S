/* rm__load_request_params @ 0x8eaccc, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_sm__action_8e4ee4, rm_sm__action_8e83f4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm__load_request_params
rm__load_request_params:
	.global L_8eaccc
L_8eaccc:
	ld_s r2,[r1,0x18]
L_8eacce:
	st_s r2,[r0,0x54]
L_8eacd0:
	ld_s r2,[r1,0x1c]
L_8eacd2:
	st_s r2,[r0,0x58]
L_8eacd4:
	mov_s r2,0x1
L_8eacd6:
	st_s r2,[r0,0x5c]
L_8eacd8:
	mov_s r2,0x0
L_8eacda:
	st_s r2,[r0,0x68]
L_8eacdc:
	st_s r2,[r0,0x60]
L_8eacde:
	ldb r1,[r1, 0x20]
L_8eace2:
	j_s.d [blink]
L_8eace4:
	stb r1,[r0, 0x78]
