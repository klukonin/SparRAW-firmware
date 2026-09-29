/* gpio__reset_mux @ 0x8d1598, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sdp_gpio__boot_init
 */
	.section .text.gpio__reset_mux,"ax",@progbits
	.global gpio__reset_mux
gpio__reset_mux:
	.global L_8d1598
L_8d1598:
	mov_s r0,0x11
L_8d159a:
	asl_s r0,r0,0x13
L_8d159c:
	st 0x22222,[r0, 0x68]
L_8d15a4:
	mov_s r1,0x0
L_8d15a6:
	st_s r1,[r0,0x6c]
L_8d15a8:
	st_s r1,[r0,0x70]
L_8d15aa:
	st_s r1,[r0,0x74]
L_8d15ac:
	st_s r1,[r0,0x78]
L_8d15ae:
	st_s r1,[r0,0x7c]
L_8d15b0:
	mov_s r0,0x880b00
L_8d15b6:
	st_s r1,[r0,0x6c]
L_8d15b8:
	st_s r1,[r0,0x70]
L_8d15ba:
	b.d L_8d15c0
L_8d15be:
	mov_s r0,0x1
	.global L_8d15c0
L_8d15c0:
	mov_s r1,0x880b80
L_8d15c6:
	st_s r0,[r1,0x4]
L_8d15c8:
	j_s [blink]
L_8d15ca:
	nop_s
