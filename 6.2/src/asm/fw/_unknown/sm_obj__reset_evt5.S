/* sm_obj__reset_evt5 @ 0x8e1354, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_conn_mgr__notify_all
 * Зовёт сам: basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_obj__reset_evt5
sm_obj__reset_evt5:
	.global L_8e1354
L_8e1354:
	mov_s r2,0x0
L_8e1356:
	st.ab r2,[r0,0x4]
L_8e135a:
	mov_s r1,0x5
L_8e135c:
	mov_s r3,r2
L_8e135e:
	b.d L_8d9b6c
L_8e1362:
	mov_s r4,r2
L_8e1364:
	mov_s r1,0x0
L_8e1366:
	mov_s r2,r0
L_8e1368:
	mov_s r3,r1
L_8e136a:
	b.d L_8d9b6c
L_8e136e:
	mov_s r4,r1
L_8e1370:
	add_s r0,r0,0xc
L_8e1372:
	ld_s r1,[r0,0x8]
L_8e1374:
	ld_s r1,[r1,0x4]
L_8e1376:
	j_s [r1]
L_8e1378:
	mov_s r1,0x0
L_8e137a:
	mov_s r2,r0
L_8e137c:
	mov_s r3,r1
L_8e137e:
	b.d L_8d9b6c
L_8e1382:
	mov_s r4,r1
L_8e1384:
	add_s r0,r0,0xc
L_8e1386:
	ld_s r1,[r0,0x8]
L_8e1388:
	ld_s r1,[r1,0x4]
L_8e138a:
	j_s [r1]
