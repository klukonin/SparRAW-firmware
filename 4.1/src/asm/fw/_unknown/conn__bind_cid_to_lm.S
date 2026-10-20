/* conn__bind_cid_to_lm @ 0x8f1358, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__activate_conn, mid__link_acquisition_action
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, lm_if__set_cid
 */
	.section .text.conn__bind_cid_to_lm,"ax",@progbits
	.global conn__bind_cid_to_lm
conn__bind_cid_to_lm:
	.global L_8f1358
L_8f1358:
	push_s blink
L_8f135a:
	bl L_8c02c4
L_8f135e:
	mov_s r13,r0
L_8f1360:
	mov_s r14,r1
L_8f1362:
	add_s r0,r0,0x64
L_8f1364:
	bl.d L_8e162c
L_8f1368:
	extb_s r1,r1
L_8f136a:
	ld_s r0,[r13,0x18]
L_8f136c:
	mov_s r3,0x0
L_8f136e:
	brne r0,0x1,L_8f137a
L_8f1372:
	ld_s r0,[r13,0x1c]
L_8f1374:
	cmp_s r0,0x0
L_8f1376:
	mov.eq r3,0x1
	.global L_8f137a
L_8f137a:
	extb_s r3,r3
L_8f137c:
	add2 r0,r13,0x3f
L_8f1380:
	mov_s r1,0x0
L_8f1382:
	mov_s r2,r14
L_8f1384:
	bl.d L_8d6a1c
L_8f1388:
	mov_s r4,r1
L_8f138a:
	.byte 0xad,0x07
