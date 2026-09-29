/* mac__set_cid_mcs @ 0x8ea3b8, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_bringup__init_tx_queues
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__set_cid_mcs
mac__set_cid_mcs:
	.global L_8ea3b8
L_8ea3b8:
	push_s blink
L_8ea3ba:
	bl L_8c01dc
L_8ea3be:
	mov_s r16,r0
L_8ea3c0:
	mov_s r0,0x1c1ddf
L_8ea3c6:
	mov_s r13,r1
L_8ea3c8:
	mov_s r14,r2
L_8ea3ca:
	bbit0 r0,r1,L_8ea40c
	.global L_8ea3ce
L_8ea3ce:
	asl r4,r16,0x5
L_8ea3d2:
	add r4,r4,0x4435800
L_8ea3da:
	lsr r4,r4,0x3
L_8ea3de:
	bic r0,r4,0x3
L_8ea3e2:
	st_s r13,[r0]
L_8ea3e4:
	breq_s r14,0,L_8ea408
L_8ea3e6:
	mov_s r1,0x886c00
L_8ea3ec:
	ld_s r0,[r1,0x74]
L_8ea3ee:
	bic r0,r0,0xff
L_8ea3f2:
	or r0,r0,0x30
L_8ea3f6:
	st_s r0,[r1,0x74]
L_8ea3f8:
	ld_s r0,[r1,0x70]
L_8ea3fa:
	and r0,r0,0xffff0000
L_8ea402:
	or r0,r0,0x14
L_8ea406:
	st_s r0,[r1,0x70]
	.global L_8ea408
L_8ea408:
	b L_8c0244
	.global L_8ea40c
L_8ea40c:
	mov_s r0,blink
L_8ea40e:
	mov_s r1,0x23
L_8ea410:
	bl.d L_8c9b28
L_8ea414:
	bset_s r1,r1,0xc
L_8ea416:
	b_s L_8ea3ce
