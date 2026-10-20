/* start_find_session @ 0x8f12f8, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   start_find_session()
 *   discovery.cpp
 * Зовут его: l2mgr__start_discovery
 * Зовёт сам: __ld_r13_ret, find_mngr__session_start, fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.start_find_session,"ax",@progbits
	.global start_find_session
start_find_session:
	.global L_8f12f8
L_8f12f8:
	push_s blink
L_8f12fa:
	push_s r13
L_8f12fc:
	mov_s r13,r0
L_8f12fe:
	mov_s r2,0x101283c
L_8f1304:
	mov_s r0,0xc
L_8f1306:
	bl.d L_8edfb0
L_8f130a:
	mov_s r1,0x2
L_8f130c:
	ld_s r0,[r13,0x8]
L_8f130e:
	ld_s r0,[r0,0x78]
L_8f1310:
	brne_s r0,0,L_8f1326
	.global L_8f1312
L_8f1312:
	ld_s r0,[r13,0x4]
L_8f1314:
	ld_s r0,[r0,0x4c]
L_8f1316:
	brne r0,0x1,L_8f133e
	.global L_8f131a
L_8f131a:
	bl.d L_8e2a8c
L_8f131e:
	add r0,r13,0xc
L_8f1322:
	b L_8c033c
	.global L_8f1326
L_8f1326:
	mov_s r0,blink
L_8f1328:
	mov_s r2,0x1012024
L_8f132e:
	mov_s r1,0x1235
L_8f1334:
	bl.d L_8c82c0
L_8f1338:
	mov r3,0x1e6
L_8f133c:
	b_s L_8f1312
	.global L_8f133e
L_8f133e:
	mov_s r0,blink
L_8f1340:
	mov_s r2,0x1012024
L_8f1346:
	mov_s r1,0x1236
L_8f134c:
	bl.d L_8c82c0
L_8f1350:
	mov r3,0x1e7
L_8f1354:
	b_s L_8f131a
L_8f1356:
	nop_s
