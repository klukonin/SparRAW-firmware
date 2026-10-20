/* llc_snap__write_header @ 0x8ec598, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_data_builder__log_addrs
 */
	.section .text.llc_snap__write_header,"ax",@progbits
	.global llc_snap__write_header
llc_snap__write_header:
	.global L_8ec598
L_8ec598:
	sub_s sp,sp,0x4
L_8ec59a:
	stw r1,[sp]
L_8ec59e:
	mov_s r1,0xaa
L_8ec5a0:
	stb_s r1,[r0]
L_8ec5a2:
	stb_s r1,[r0,0x1]
L_8ec5a4:
	mov_s r1,0x3
L_8ec5a6:
	stb_s r1,[r0,0x2]
L_8ec5a8:
	mov_s r1,0x0
L_8ec5aa:
	stb_s r1,[r0,0x3]
L_8ec5ac:
	stb_s r1,[r0,0x4]
L_8ec5ae:
	stb_s r1,[r0,0x5]
L_8ec5b0:
	ldb_s r1,[sp,0x0]
L_8ec5b2:
	stb_s r1,[r0,0x6]
L_8ec5b4:
	ldb r1,[sp, 0x1]
L_8ec5b8:
	stb_s r1,[r0,0x7]
L_8ec5ba:
	mov_s r0,0x8
L_8ec5bc:
	j_s.d [blink]
L_8ec5be:
	add_s sp,sp,0x4
