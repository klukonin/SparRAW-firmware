/* mac_ring_enable @ 0x8ea438, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring, tx_macq__setup
 * Зовёт сам: macq__kick_queue
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_ring_enable
mac_ring_enable:
	.global L_8ea438
L_8ea438:
	mov_s r3,0x886a00
L_8ea43e:
	ld_s r2,[r3,0x14]
L_8ea440:
	asl_s r1,r1,r0
L_8ea442:
	bclr r2,r2,r0
L_8ea446:
	or_s r1,r1,r2
L_8ea448:
	st_s r1,[r3,0x14]
L_8ea44a:
	b L_8e1c7c
L_8ea44e:
	nop_s
