/* rx_mgmt_prs_step @ 0x8de0fc, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_mgmt_prs__parse
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_mgmt_prs_step
rx_mgmt_prs_step:
	.global L_8de0fc
L_8de0fc:
	push_s blink
L_8de0fe:
	bl.d L_8c01e0
L_8de102:
	mov_s r0,r4
L_8de104:
	ld r4,[r3]
L_8de108:
	mov_s r13,0x0
L_8de10a:
	stb_s r13,[r2,0x4]
L_8de10c:
	stb_s r13,[r0]
L_8de10e:
	add3 r14,r2,0x10
L_8de112:
	st_s r1,[r14,0x30]
L_8de114:
	ldb_s r15,[r2,0x4]
L_8de116:
	add r13,r1,0x8
L_8de11a:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8de11c:
	stb_s r15,[r2,0x4]
L_8de11e:
	ldb_s r15,[r0]
L_8de120:
	add_s r15,r15,0x8
L_8de122:
	stb_s r15,[r0]
L_8de124:
	st_s r13,[r14,0x38]
L_8de126:
	ldb_s r15,[r2,0x4]
L_8de128:
	add r13,r1,0xb
L_8de12c:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8de12e:
	stb_s r15,[r2,0x4]
L_8de130:
	ldb_s r15,[r0]
L_8de132:
	/* add_s r15,0x3 */
	.byte 0x03,0xe7
L_8de134:
	stb_s r15,[r0]
L_8de136:
	st_s r13,[r14,0x3c]
L_8de138:
	ldb_s r15,[r2,0x4]
L_8de13a:
	add r13,r1,0xd
L_8de13e:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8de140:
	stb_s r15,[r2,0x4]
L_8de142:
	ldb_s r15,[r0]
L_8de144:
	/* add_s r15,0x2 */
	.byte 0x02,0xe7
L_8de146:
	stb_s r15,[r0]
L_8de148:
	st_s r13,[r14,0x40]
L_8de14a:
	ldb_s r15,[r2,0x4]
L_8de14c:
	add r13,r1,0x13
L_8de150:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8de152:
	stb_s r15,[r2,0x4]
L_8de154:
	ldb_s r15,[r0]
L_8de156:
	add_s r1,r1,0x14
L_8de158:
	/* add_s r15,0x6 */
	.byte 0x06,0xe7
L_8de15a:
	stb_s r15,[r0]
L_8de15c:
	ldb_s r15,[r2,0x4]
L_8de15e:
	st_s r13,[r14,0x4]
L_8de160:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8de162:
	stb_s r15,[r2,0x4]
L_8de164:
	ldb_s r15,[r0]
L_8de166:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8de168:
	stb_s r15,[r0]
L_8de16a:
	ld_s r15,[r14,0x40]
L_8de16c:
	ldb_s r15,[r15]
L_8de16e:
	sub r13,r4,0x14
L_8de172:
	bbit0 r15,0x0,L_8de186
L_8de176:
	st_s r1,[r14,0x44]
L_8de178:
	ldb_s r1,[r2,0x4]
L_8de17a:
	sub_s r13,r13,0x8
L_8de17c:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8de17e:
	stb_s r1,[r2,0x4]
L_8de180:
	ldb_s r1,[r0]
L_8de182:
	add_s r1,r1,0x8
L_8de184:
	stb_s r1,[r0]
	.global L_8de186
L_8de186:
	st_s r13,[r3]
L_8de188:
	b.d L_8c024c
L_8de18c:
	mov_s r0,0x1
L_8de18e:
	nop_s
