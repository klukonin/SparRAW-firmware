/* aw__walk_peer_bits_noop @ 0x9263b8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_worker__collect_awake_peers
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global aw__walk_peer_bits_noop
aw__walk_peer_bits_noop:
	.global L_9263b8
L_9263b8:
	b_s L_9263ca
	.global L_9263ba
L_9263ba:
	norm r2,r0
L_9263be:
	rsub r1,r2,0x1e
L_9263c2:
	extb_s r1,r1
L_9263c4:
	bclr r0,r0,r1
