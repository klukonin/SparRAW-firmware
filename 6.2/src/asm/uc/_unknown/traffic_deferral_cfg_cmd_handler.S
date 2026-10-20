/* traffic_deferral_cfg_cmd_handler @ 0x937430, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   traffic_deferral_cfg_cmd_handler (deferred = %d) (wakeup_trigger=%d)
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, traffic_deferral__clear_node, traffic_deferral__is_enabled, uc_log__emit2, uc_send_evt_typed
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global traffic_deferral_cfg_cmd_handler
traffic_deferral_cfg_cmd_handler:
	.global L_937430
L_937430:
	push_s blink
L_937432:
	push_s r13
L_937434:
	mov_s r13,r0
L_937436:
	ldb_s r2,[r13]
L_937438:
	mov_s r1,0x10014e8
L_93743e:
	mov_s r0,0x20
L_937440:
	bl.d L_92d27c
L_937444:
	ldb_s r3,[r13,0x1]
L_937446:
	ldb_s r1,[r13]
L_937448:
	mov_s r0,0x802f80
L_93744e:
	breq_s r1,0,L_93746c
L_937450:
	bl.d L_935654
L_937454:
	ldb_s r1,[r13,0x1]
L_937456:
	cmp_s r0,0x0
L_937458:
	mov_s r0,0x18
L_93745a:
	beq_s L_937464
L_93745c:
	bl.d L_927928
L_937460:
	mov_s r1,0x0
L_937462:
	b_s L_937470
	.global L_937464
L_937464:
	bl.d L_927928
L_937468:
	mov_s r1,0x1
L_93746a:
	b_s L_937470
	.global L_93746c
L_93746c:
	bl L_935644
	.global L_937470
L_937470:
	b L_9202ac
