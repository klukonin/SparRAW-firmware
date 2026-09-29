/* l2mgr__mac_started_log @ 0x8f141c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [L2MGR] MAC %d started : ADDR-%04X%08X
 * Зовут его: l2mgr__init, wmi_handler_port_allocate
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit3, l2mgr_mac_start_step, mac__apply_multicast_addr, mid__open, mid_list__insert
 */
	.section .text.l2mgr__mac_started_log,"ax",@progbits
	.global l2mgr__mac_started_log
l2mgr__mac_started_log:
	.global L_8f141c
L_8f141c:
	push_s blink
L_8f141e:
	bl L_8c02b4
L_8f1422:
	mov_s r16,r0
L_8f1424:
	mov_s r13,r1
L_8f1426:
	mov_s r18,r2
L_8f1428:
	bl.d L_8c2d4c
L_8f142c:
	mov_s r17,r3
L_8f142e:
	mov.f r14,r0
L_8f1432:
	beq_s L_8f146e
L_8f1434:
	bl.d L_8e1a68
L_8f1438:
	mov_s r1,r13
L_8f143a:
	add3 r0,r14,0x9
L_8f143e:
	mov_s r1,r13
L_8f1440:
	mov_s r2,r18
L_8f1442:
	mov_s r3,r17
L_8f1444:
	mov_s r15,0x1
L_8f1446:
	bl.d L_8c43dc
L_8f144a:
	mov_s r4,r15
L_8f144c:
	bl.d L_8e1248
L_8f1450:
	mov_s r0,r14
L_8f1452:
	ldw r4,[r13, 0x4]
L_8f1456:
	mov_s r2,0x100d368
L_8f145c:
	ld r5,[r13]
L_8f1460:
	mov_s r0,0xb
L_8f1462:
	mov_s r1,0x2
L_8f1464:
	bl.d L_8ee034
L_8f1468:
	mov_s r3,r16
L_8f146a:
	mov_s r0,r15
L_8f146c:
	b_s L_8f1470
	.global L_8f146e
L_8f146e:
	mov_s r0,0x0
	.global L_8f1470
L_8f1470:
	b L_8c0314
