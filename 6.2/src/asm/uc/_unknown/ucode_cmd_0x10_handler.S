/* ucode_cmd_0x10_handler @ 0x9220d4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x10_handler
ucode_cmd_0x10_handler:
	.global L_9220d4
L_9220d4:
	ldb_s r1,[r0,0x8]
L_9220d6:
	mov_s r3,0x8021b8
L_9220dc:
	stb_s r1,[r3,0x8]
L_9220de:
	ldb_s r1,[r0,0xa]
L_9220e0:
	stb_s r1,[r3,0xa]
L_9220e2:
	ldb_s r1,[r0,0x9]
L_9220e4:
	stb_s r1,[r3,0x9]
L_9220e6:
	ldb_s r1,[r0,0xb]
L_9220e8:
	stb_s r1,[r3,0xb]
L_9220ea:
	ldb_s r1,[r0,0xc]
L_9220ec:
	rsub r2,r1,0x20
L_9220f0:
	mov_s r1,0x0
L_9220f2:
	bset r1,r1,r2
L_9220f6:
	st_s r1,[r3,0xc]
L_9220f8:
	ld_s r1,[r0]
L_9220fa:
	st_s r1,[r3,0x4]
L_9220fc:
	ldb_s r1,[r0,0xd]
L_9220fe:
	stb r1,[r3, 0x24]
L_922102:
	ldb_s r0,[r0,0xe]
L_922104:
	j_s.d [blink]
L_922106:
	stb r0,[r3, 0x25]
L_92210a:
	nop_s
