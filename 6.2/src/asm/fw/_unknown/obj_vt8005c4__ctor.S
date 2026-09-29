/* obj_vt8005c4__ctor @ 0x8c187c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__install_handler_ptrs, obj_vt8005e4__ctor
 * Зовёт сам: __ld_r13_to_r13_ret, memset_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt8005c4__ctor
obj_vt8005c4__ctor:
	.global L_8c187c
L_8c187c:
	push_s blink
L_8c187e:
	push_s r13
L_8c1880:
	mov_s r13,r0
L_8c1882:
	mov_s r0,0x8005c4
L_8c1888:
	st_s r0,[r13,0x44]
L_8c188a:
	mov_s r0,r13
L_8c188c:
	mov_s r1,0xff
L_8c188e:
	bl.d L_8ddf84
L_8c1892:
	mov_s r2,0x40
L_8c1894:
	mov_s r0,0x0
L_8c1896:
	b.d L_8c025c
L_8c189a:
	stb r0,[r13, 0x40]
L_8c189e:
	nop_s
	.global L_8c18a0
L_8c18a0:
	mov_s r3,0x857260
L_8c18a6:
	mov_s r2,0x0
L_8c18a8:
	add_s r1,r3,0x4
L_8c18aa:
	st_s r1,[r0,0x4]
L_8c18ac:
	stb_s r2,[r0]
L_8c18ae:
	stb_s r2,[r3,0x4]
L_8c18b0:
	ld_s r1,[r0,0x4]
L_8c18b2:
	stb_s r2,[r1,0x1]
L_8c18b4:
	ld_s r0,[r0,0x4]
L_8c18b6:
	j_s.d [blink]
L_8c18b8:
	stb_s r2,[r0,0x2]
L_8c18ba:
	nop_s
	.global L_8c18bc
L_8c18bc:
	mov_s r1,0x0
L_8c18be:
	st_s r1,[r0]
L_8c18c0:
	stb_s r1,[r0,0x4]
L_8c18c2:
	st_s r1,[r0,0xc]
L_8c18c4:
	st_s r1,[r0,0x10]
L_8c18c6:
	st_s r1,[r0,0x14]
L_8c18c8:
	j_s.d [blink]
L_8c18ca:
	stb_s r1,[r0,0x18]
