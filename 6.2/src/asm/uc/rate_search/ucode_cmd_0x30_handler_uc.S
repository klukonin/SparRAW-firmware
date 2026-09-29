/* ucode_cmd_0x30_handler_uc @ 0x92ff04, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, bits__set_u8_s0_w7_uc, rs_abort, rs_start
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x30_handler_uc
ucode_cmd_0x30_handler_uc:
	.global L_92ff04
L_92ff04:
	push_s blink
L_92ff06:
	push_s r13
L_92ff08:
	mov_s r13,r0
L_92ff0a:
	bl.d L_92fb80
L_92ff0e:
	ldb_s r0,[r0]
L_92ff10:
	ldb_s r1,[r13,0x1]
L_92ff12:
	ldb_s r0,[r13]
L_92ff14:
	bmsk_s r1,r1,0x0
L_92ff16:
	mov_s r3,0x8006ac
L_92ff1c:
	asl_s r2,r1,0x7
L_92ff1e:
	add_s r0,r0,r3
L_92ff20:
	ldb_s r1,[r0]
L_92ff22:
	bclr_s r1,r1,0x7
L_92ff24:
	or_s r1,r1,r2
L_92ff26:
	stb_s r1,[r0]
L_92ff28:
	ldb_s r1,[r13,0x2]
L_92ff2a:
	ldb_s r2,[r13]
L_92ff2c:
	bmsk_s r1,r1,0x6
L_92ff2e:
	add_s r2,r2,r3
L_92ff30:
	mov_s r0,r2
L_92ff32:
	bl L_93e360
L_92ff36:
	ldb_s r0,[r13]
L_92ff38:
	bl.d L_9300ec
L_92ff3c:
	mov_s r1,0x0
L_92ff3e:
	b L_9202ac
L_92ff42:
	nop_s
