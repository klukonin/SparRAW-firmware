/* bi_ap_mon_if__trigger_bhi @ 0x930564, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: bi_ap_mon_if__trigger, bi_window_timing_update, bi_window_transition_prep
 */
	.section .text.bi_ap_mon_if__trigger_bhi,"ax",@progbits
	.global bi_ap_mon_if__trigger_bhi
bi_ap_mon_if__trigger_bhi:
L_930564:
	bl L_9370b8
L_930568:
	ld.as r1,[gp,-0x34]
L_93056c:
	mov_s r13,0x801de8
L_930572:
	breq_s r1,0,L_930598
L_930574:
	ld_s r0,[gp,-0x8c]
L_930576:
	brne_s r0,0,L_930598
L_930578:
	ld r3,[0x801438]
L_930580:
	breq r3,0x2,L_930598
L_930584:
	bl.d L_921ce8
L_930588:
	mov r0,0x0
L_93058c:
	mov_s r0,r13
L_93058e:
	mov_s r1,0x3
L_930590:
	b.d L_93050c
L_930594:
	mov r2,0x0
	.global L_930598
L_930598:
	mov_s r0,r13
L_93059a:
	mov_s r1,0x2
L_93059c:
	b.d L_93050c
L_9305a0:
	mov r2,0x0
