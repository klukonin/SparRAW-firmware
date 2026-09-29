/* txrx_sel @ 0x8ea5f0, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txrx_sel - NO RF on current platform!!!
 * Зовут его: silent_rssi__set_rf_gain_index
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, rf__is_present, rf_sector_commit_rx, rf_sector_commit_tx
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global txrx_sel
txrx_sel:
	.global L_8ea5f0
L_8ea5f0:
	push_s blink
L_8ea5f2:
	bl L_8c01e0
L_8ea5f6:
	mov_s r13,r1
L_8ea5f8:
	mov_s r14,r2
L_8ea5fa:
	bl.d L_8da5d8
L_8ea5fe:
	mov_s r15,r3
L_8ea600:
	brne_s r0,0,L_8ea610
L_8ea602:
	mov_s r1,0x100522c
L_8ea608:
	bl.d L_8dcba8
L_8ea60c:
	mov_s r0,0x10
L_8ea60e:
	b_s L_8ea628
	.global L_8ea610
L_8ea610:
	brne_s r14,0,L_8ea61c
L_8ea612:
	extb_s r0,r13
L_8ea614:
	bl.d L_8d40d8
L_8ea618:
	extb_s r1,r15
L_8ea61a:
	b_s L_8ea628
	.global L_8ea61c
L_8ea61c:
	brne r14,0x1,L_8ea628
L_8ea620:
	extb_s r0,r13
L_8ea622:
	bl.d L_8d37dc
L_8ea626:
	extb_s r1,r15
	.global L_8ea628
L_8ea628:
	b L_8c024c
