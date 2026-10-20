/* llc_snap__write_header @ 0x8d7d90, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_main_sm__bf_ntf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global llc_snap__write_header
llc_snap__write_header:
	.global L_8d7d90
L_8d7d90:
	sub_s sp,sp,0x4
L_8d7d92:
	stw r1,[sp]
L_8d7d96:
	mov_s r1,0xaa
L_8d7d98:
	stb_s r1,[r0]
L_8d7d9a:
	stb_s r1,[r0,0x1]
L_8d7d9c:
	mov_s r1,0x3
L_8d7d9e:
	stb_s r1,[r0,0x2]
L_8d7da0:
	mov_s r1,0x0
L_8d7da2:
	stb_s r1,[r0,0x3]
L_8d7da4:
	stb_s r1,[r0,0x4]
L_8d7da6:
	stb_s r1,[r0,0x5]
L_8d7da8:
	ldb_s r1,[sp,0x0]
L_8d7daa:
	stb_s r1,[r0,0x6]
L_8d7dac:
	ldb r1,[sp, 0x1]
L_8d7db0:
	stb_s r1,[r0,0x7]
L_8d7db2:
	mov_s r0,0x8
L_8d7db4:
	j_s.d [blink]
L_8d7db6:
	add_s sp,sp,0x4
