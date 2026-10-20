/* set_tk @ 0x8e2134, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    New TK is handled:
 *    Fixed TK:
 * Зовут его: WMI_ADD_CIPHER_KEY_CMD
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit0, key__install_by_type, log_hexdump
 */
	.section .text.set_tk,"ax",@progbits
	.global set_tk
set_tk:
	.global L_8e2134
L_8e2134:
	push_s blink
L_8e2136:
	bl L_8c02bc
L_8e213a:
	mov_s r13,r0
L_8e213c:
	mov_s r14,r1
L_8e213e:
	mov_s r16,r2
L_8e2140:
	mov_s r2,0x100e300
L_8e2146:
	mov_s r0,0xe
L_8e2148:
	bl.d L_8edfb0
L_8e214c:
	mov_s r1,0x2
L_8e214e:
	mov_s r0,r14
L_8e2150:
	bl.d L_8c7f90
L_8e2154:
	mov_s r1,0x10
L_8e2156:
	mov_s r3,0xf
L_8e2158:
	mov_s r1,0x0
L_8e215a:
	add r15,r13,0x20
L_8e215e:
	mov lp_count,0x10
L_8e2162:
	add r2,r13,0x24
L_8e2166:
	lp L_8e2174
L_8e216a:
	ldb_s r0,[r14,r3]
L_8e216c:
	add_s r12,r2,r1
L_8e216e:
	stb_s r0,[r12]
L_8e2170:
	/* sub_s r3,r3,0x1 */
	.byte 0x61,0xbb
L_8e2172:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8e2174
L_8e2174:
	stb r16,[r15, 0x14]
L_8e2178:
	mov_s r2,0x100e314
L_8e217e:
	mov_s r0,0xe
L_8e2180:
	bl.d L_8edfb0
L_8e2184:
	mov_s r1,0x2
L_8e2186:
	add r14,r13,0x24
L_8e218a:
	mov_s r0,r14
L_8e218c:
	bl.d L_8c7f90
L_8e2190:
	mov_s r1,0x10
L_8e2192:
	mov_s r0,r14
L_8e2194:
	ldb_s r1,[r15,0x14]
L_8e2196:
	mov_s r2,0x0
L_8e2198:
	bl.d L_8d4104
L_8e219c:
	ldb_s r3,[r13,0x8]
L_8e219e:
	b L_8c0324
L_8e21a2:
	nop_s
