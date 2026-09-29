/* conn__abort @ 0x8f0444, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn::abort(): cid=%d
 * Зовут его: conn_mgr__link_down_evt, scan_mngr__prob_done
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__handle_event, conn__teardown_mac_rules, fw_log_emit1, lm_if__disable_link_loss_monitoring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__abort
conn__abort:
	.global L_8f0444
L_8f0444:
	push_s blink
L_8f0446:
	bl L_8c01dc
L_8f044a:
	mov_s r14,r0
L_8f044c:
	mov_s r15,r1
L_8f044e:
	mov_s r1,0x1010330
L_8f0454:
	mov_s r0,0x2b
L_8f0456:
	bl.d L_8dcc10
L_8f045a:
	ldb_s r2,[r14,0x8]
L_8f045c:
	mov_s r1,0x857200
L_8f0462:
	ldb_s r2,[r14,0x8]
L_8f0464:
	ld_s r0,[r1,0x4c]
L_8f0466:
	mov_s r13,0x0
L_8f0468:
	bclr r0,r0,r2
L_8f046c:
	st_s r0,[r1,0x4c]
L_8f046e:
	ldb_s r2,[r14,0x8]
L_8f0470:
	ld_s r0,[r1,0x48]
L_8f0472:
	mov_s r16,r14
L_8f0474:
	bclr r0,r0,r2
L_8f0478:
	st_s r0,[r1,0x48]
L_8f047a:
	ldb_s r1,[r14,0x8]
L_8f047c:
	mov_s r0,0x857748
L_8f0482:
	add2_s r0,r0,r1
L_8f0484:
	st_s r13,[r0]
L_8f0486:
	add r16,r16,0x124
L_8f048a:
	brne_s r15,0,L_8f04aa
L_8f048c:
	bl.d L_8f9400
L_8f0490:
	mov_s r0,r14
L_8f0492:
	mov_s r0,r16
L_8f0494:
	mov_s r1,0xa
L_8f0496:
	mov_s r2,r13
L_8f0498:
	mov_s r3,r13
L_8f049a:
	bl.d L_8d9b6c
L_8f049e:
	mov_s r4,r13
L_8f04a0:
	bl.d L_8c8f90
L_8f04a4:
	add3 r0,r14,0xe
L_8f04a8:
	b_s L_8f04b8
	.global L_8f04aa
L_8f04aa:
	mov_s r0,r16
L_8f04ac:
	mov_s r1,0xa
L_8f04ae:
	mov_s r2,r13
L_8f04b0:
	mov_s r3,r13
L_8f04b2:
	bl.d L_8d9b6c
L_8f04b6:
	mov_s r4,r13
	.global L_8f04b8
L_8f04b8:
	b L_8c0244
