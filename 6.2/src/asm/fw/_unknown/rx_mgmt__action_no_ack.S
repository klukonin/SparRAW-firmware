/* rx_mgmt__action_no_ack @ 0x8c21e0, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   action no ack - action 0x%x, category_code 0x%x
 *   action no ack - Ignore action 0x%x, category_code 0x%x
 * Зовут его: rx_mgmt_srvs__distribute
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit2, hexdump_words, mem_pool__free_thunk, stream_mgr__action
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_mgmt__action_no_ack
rx_mgmt__action_no_ack:
	.global L_8c21e0
L_8c21e0:
	push_s blink
L_8c21e2:
	push_s r13
L_8c21e4:
	mov_s r13,r0
L_8c21e6:
	ld_s r0,[r0,0x14]
L_8c21e8:
	ldb.a r3,[r0,0x18]
L_8c21ec:
	ldb_s r2,[r0,0x1]
L_8c21ee:
	cmp_s r3,0x10
L_8c21f0:
	cmp.eq r2,0x3
L_8c21f4:
	bne_s L_8c220a
L_8c21f6:
	mov_s r1,0x101088c
L_8c21fc:
	bl.d L_8dcc80
L_8c2200:
	mov_s r0,0x2b
L_8c2202:
	bl.d L_8c1e08
L_8c2206:
	mov_s r0,r13
L_8c2208:
	b_s L_8c2224
	.global L_8c220a
L_8c220a:
	mov_s r1,0x10108c0
L_8c2210:
	bl.d L_8dcc80
L_8c2214:
	mov_s r0,0x2b
L_8c2216:
	ld_s r0,[r13,0x14]
L_8c2218:
	bl.d L_8c9790
L_8c221c:
	ld_s r1,[r13,0x30]
L_8c221e:
	bl.d L_8cb15c
L_8c2222:
	mov_s r0,r13
	.global L_8c2224
L_8c2224:
	b L_8c025c
