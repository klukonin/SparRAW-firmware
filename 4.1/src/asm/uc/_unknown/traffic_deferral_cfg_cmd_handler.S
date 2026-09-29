/* traffic_deferral_cfg_cmd_handler @ 0x932488, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   traffic_deferral_cfg_cmd_handler (deferred = %d) (wakeup_trigger=%d)
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, traffic_deferral__clear_node, traffic_deferral__is_enabled, uc_send_evt_typed
 */
	.section .text.traffic_deferral_cfg_cmd_handler,"ax",@progbits
	.global traffic_deferral_cfg_cmd_handler
traffic_deferral_cfg_cmd_handler:
	.global L_932488
L_932488:
	push_s blink
L_93248a:
	bl.d L_920210
L_93248e:
	mov_s r1,r0
L_932490:
	ldb_s r14,[r0]
L_932492:
	mov_s r3,0x80209c
L_932498:
	ldb_s r2,[r0,0x1]
L_93249a:
	ldb_s r0,[r3,0x4]
L_93249c:
	mov r4,0x10018ec
L_9324a4:
	bbit0 r0,0x2,L_9324da
L_9324a8:
	ld_s r0,[r3]
L_9324aa:
	mov_s r13,0x8020b0
L_9324b0:
	add_s r15,r0,0x2
L_9324b2:
	extb_s r15,r15
L_9324b4:
	add2 r15,r13,r15
L_9324b8:
	st_s r2,[r15]
L_9324ba:
	add_s r2,r0,0x1
L_9324bc:
	extb_s r2,r2
L_9324be:
	add2 r2,r13,r2
L_9324c2:
	st_s r14,[r2]
L_9324c4:
	bmsk r2,r4,0x13
L_9324c8:
	or r2,r2,0xaa000000
L_9324d0:
	extb_s r14,r0
L_9324d2:
	add2_s r13,r13,r14
L_9324d4:
	st_s r2,[r13]
L_9324d6:
	/* add_s r0,0x3 */
	.byte 0x03,0xe0
L_9324d8:
	st_s r0,[r3]
	.global L_9324da
L_9324da:
	ldb_s r2,[r1]
L_9324dc:
	mov_s r0,0x801ed0
L_9324e2:
	breq_s r2,0,L_932500
L_9324e4:
	bl.d L_930bfc
L_9324e8:
	ldb_s r1,[r1,0x1]
L_9324ea:
	cmp_s r0,0x0
L_9324ec:
	mov_s r0,0x18
L_9324ee:
	beq_s L_9324f8
L_9324f0:
	bl.d L_925da8
L_9324f4:
	mov_s r1,0x0
L_9324f6:
	b_s L_932504
	.global L_9324f8
L_9324f8:
	bl.d L_925da8
L_9324fc:
	mov_s r1,0x1
L_9324fe:
	b_s L_932504
	.global L_932500
L_932500:
	bl L_930bec
	.global L_932504
L_932504:
	b L_92027c
