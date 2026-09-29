/* txrx_sel @ 0x8e52c4, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txrx_sel - NO RF on current platform!!!
 * Зовут его: calib_silent_rssi_sparrow
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, rf__is_present, rf_sector_commit_rx, rf_sector_commit_tx
 */
	.section .text.txrx_sel,"ax",@progbits
	.global txrx_sel
txrx_sel:
	.global L_8e52c4
L_8e52c4:
	push_s blink
L_8e52c6:
	bl L_8c02c0
L_8e52ca:
	mov_s r13,r1
L_8e52cc:
	mov_s r14,r2
L_8e52ce:
	bl.d L_8d750c
L_8e52d2:
	mov_s r15,r3
L_8e52d4:
	brne_s r0,0,L_8e52e6
L_8e52d6:
	mov_s r2,0x1005360
L_8e52dc:
	mov_s r0,0x0
L_8e52de:
	bl.d L_8edfb0
L_8e52e2:
	mov_s r1,0x1
L_8e52e4:
	b_s L_8e52fe
	.global L_8e52e6
L_8e52e6:
	brne_s r14,0,L_8e52f2
L_8e52e8:
	extb_s r0,r13
L_8e52ea:
	bl.d L_8d0ef4
L_8e52ee:
	extb_s r1,r15
L_8e52f0:
	b_s L_8e52fe
	.global L_8e52f2
L_8e52f2:
	brne r14,0x1,L_8e52fe
L_8e52f6:
	extb_s r0,r13
L_8e52f8:
	bl.d L_8d073c
L_8e52fc:
	extb_s r1,r15
	.global L_8e52fe
L_8e52fe:
	b L_8c032c
L_8e5302:
	nop_s
