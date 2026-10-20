/* rx_mgmt_prs__parse_dmg_bcon_fixed @ 0x8da1f0, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_mgmt_prs__parse
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.rx_mgmt_prs__parse_dmg_bcon_fixed,"ax",@progbits
	.global rx_mgmt_prs__parse_dmg_bcon_fixed
rx_mgmt_prs__parse_dmg_bcon_fixed:
	.global L_8da1f0
L_8da1f0:
	push_s blink
L_8da1f2:
	bl.d L_8c02c0
L_8da1f6:
	mov_s r0,r4
L_8da1f8:
	ld r4,[r3]
L_8da1fc:
	mov_s r13,0x0
L_8da1fe:
	stb_s r13,[r2,0x4]
L_8da200:
	stb_s r13,[r0]
L_8da202:
	add3 r14,r2,0x10
L_8da206:
	st_s r1,[r14,0x30]
L_8da208:
	ldb_s r15,[r2,0x4]
L_8da20a:
	add r13,r1,0x8
L_8da20e:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8da210:
	stb_s r15,[r2,0x4]
L_8da212:
	ldb_s r15,[r0]
L_8da214:
	add_s r15,r15,0x8
L_8da216:
	stb_s r15,[r0]
L_8da218:
	st_s r13,[r14,0x38]
L_8da21a:
	ldb_s r15,[r2,0x4]
L_8da21c:
	add r13,r1,0xb
L_8da220:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8da222:
	stb_s r15,[r2,0x4]
L_8da224:
	ldb_s r15,[r0]
L_8da226:
	/* add_s r15,0x3 */
	.byte 0x03,0xe7
L_8da228:
	stb_s r15,[r0]
L_8da22a:
	st_s r13,[r14,0x3c]
L_8da22c:
	ldb_s r15,[r2,0x4]
L_8da22e:
	add r13,r1,0xd
L_8da232:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8da234:
	stb_s r15,[r2,0x4]
L_8da236:
	ldb_s r15,[r0]
L_8da238:
	/* add_s r15,0x2 */
	.byte 0x02,0xe7
L_8da23a:
	stb_s r15,[r0]
L_8da23c:
	st_s r13,[r14,0x40]
L_8da23e:
	ldb_s r15,[r2,0x4]
L_8da240:
	add r13,r1,0x13
L_8da244:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8da246:
	stb_s r15,[r2,0x4]
L_8da248:
	ldb_s r15,[r0]
L_8da24a:
	add_s r1,r1,0x14
L_8da24c:
	/* add_s r15,0x6 */
	.byte 0x06,0xe7
L_8da24e:
	stb_s r15,[r0]
L_8da250:
	ldb_s r15,[r2,0x4]
L_8da252:
	st_s r13,[r14,0x4]
L_8da254:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8da256:
	stb_s r15,[r2,0x4]
L_8da258:
	ldb_s r15,[r0]
L_8da25a:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8da25c:
	stb_s r15,[r0]
L_8da25e:
	ld_s r15,[r14,0x40]
L_8da260:
	ldb_s r15,[r15]
L_8da262:
	sub r13,r4,0x14
L_8da266:
	bbit0 r15,0x0,L_8da27a
L_8da26a:
	st_s r1,[r14,0x44]
L_8da26c:
	ldb_s r1,[r2,0x4]
L_8da26e:
	sub_s r13,r13,0x8
L_8da270:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8da272:
	stb_s r1,[r2,0x4]
L_8da274:
	ldb_s r1,[r0]
L_8da276:
	add_s r1,r1,0x8
L_8da278:
	stb_s r1,[r0]
	.global L_8da27a
L_8da27a:
	st_s r13,[r3]
L_8da27c:
	b.d L_8c032c
L_8da280:
	mov_s r0,0x1
L_8da282:
	nop_s
