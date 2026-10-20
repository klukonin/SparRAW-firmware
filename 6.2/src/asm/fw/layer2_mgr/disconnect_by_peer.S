/* disconnect_by_peer @ 0x8f2584, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   disconnect_by_peer:: MID:[%d] reason = %d  protocol %d
 * Зовут его: mlme_notify
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn__disconnect, fw_log_emit3, mid__state_is_2_or_3, mid_list__by_mid_fw, pbss__disconnect_by_peer
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global disconnect_by_peer
disconnect_by_peer:
	.global L_8f2584
L_8f2584:
	push_s blink
L_8f2586:
	bl L_8c01dc
L_8f258a:
	mov_s r15,r0
L_8f258c:
	mov_s r16,r1
L_8f258e:
	mov_s r13,r2
L_8f2590:
	bl.d L_8da488
L_8f2594:
	mov_s r14,r3
L_8f2596:
	brne_s r0,0,L_8f25a6
L_8f2598:
	bl.d L_8cc3dc
L_8f259c:
	mov_s r0,r15
L_8f259e:
	mov_s r1,r13
L_8f25a0:
	bl.d L_8c9164
L_8f25a4:
	mov_s r2,r14
	.global L_8f25a6
L_8f25a6:
	mov_s r1,0x100d658
L_8f25ac:
	mov_s r0,0x2b
L_8f25ae:
	mov_s r2,r15
L_8f25b0:
	mov_s r3,r13
L_8f25b2:
	bl.d L_8dcd00
L_8f25b6:
	mov_s r4,r14
L_8f25b8:
	mov_s r0,r16
L_8f25ba:
	mov_s r1,r13
L_8f25bc:
	bl.d L_8f2540
L_8f25c0:
	mov_s r2,r14
L_8f25c2:
	b L_8c0244
L_8f25c6:
	nop_s
