/* mac_ring_enable @ 0x8e50ac, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring, tx_macq__setup
 * Зовёт сам: mac_kick_ring
 */
	.section .text.mac_ring_enable,"ax",@progbits
	.global mac_ring_enable
mac_ring_enable:
	.global L_8e50ac
L_8e50ac:
	mov_s r3,0x886a00
L_8e50b2:
	ld_s r2,[r3,0x14]
L_8e50b4:
	asl_s r1,r1,r0
L_8e50b6:
	bclr r2,r2,r0
L_8e50ba:
	or_s r1,r1,r2
L_8e50bc:
	st_s r1,[r3,0x14]
L_8e50be:
	b L_8ddb54
L_8e50c2:
	nop_s
