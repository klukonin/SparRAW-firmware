/* set_tk @ 0x8e7140, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    New TK is handled:
 *    Fixed TK:
 * Зовут его: wmi_add_cipher_key
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, hexdump_words, key__install_by_type
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global set_tk
set_tk:
	.global L_8e7140
L_8e7140:
	push_s blink
L_8e7142:
	bl L_8c01e0
L_8e7146:
	mov_s r13,r0
L_8e7148:
	mov_s r14,r1
L_8e714a:
	mov_s r15,r2
L_8e714c:
	mov_s r1,0x1010364
L_8e7152:
	bl.d L_8dcba8
L_8e7156:
	mov_s r0,0x2e
L_8e7158:
	mov_s r0,r14
L_8e715a:
	bl.d L_8c9790
L_8e715e:
	mov_s r1,0x10
L_8e7160:
	mov_s r2,0xf
L_8e7162:
	mov lp_count,0x10
L_8e7166:
	mov_s r1,0x0
L_8e7168:
	lp L_8e717a
L_8e716c:
	ldb_s r3,[r14,r2]
L_8e716e:
	add r0,r13,0x30
L_8e7172:
	add_s r0,r0,r1
L_8e7174:
	stb_s r3,[r0]
L_8e7176:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_8e7178:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8e717a
L_8e717a:
	stb r15,[r13, 0x40]
L_8e717e:
	mov_s r1,0x1010378
L_8e7184:
	bl.d L_8dcba8
L_8e7188:
	mov_s r0,0x2e
L_8e718a:
	add r14,r13,0x30
L_8e718e:
	mov_s r0,r14
L_8e7190:
	bl.d L_8c9790
L_8e7194:
	mov_s r1,0x10
L_8e7196:
	mov_s r0,r14
L_8e7198:
	ldb r1,[r13, 0x40]
L_8e719c:
	mov_s r2,0x0
L_8e719e:
	bl.d L_8d6e68
L_8e71a2:
	ldb_s r3,[r13,0x8]
L_8e71a4:
	b L_8c024c
