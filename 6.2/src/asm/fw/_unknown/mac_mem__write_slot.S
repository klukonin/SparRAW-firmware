/* mac_mem__write_slot @ 0x8d0620, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, vring_hw__set_ready_bit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_mem__write_slot
mac_mem__write_slot:
	.global L_8d0620
L_8d0620:
	push_s blink
L_8d0622:
	bl L_8c01dc
L_8d0626:
	mov_s r13,r0
L_8d0628:
	mov_s r14,r1
L_8d062a:
	bl.d L_8d0598
L_8d062e:
	mov_s r16,r2
L_8d0630:
	mul64 r13,0x380
L_8d0634:
	add r1,mlo,0x4409980
L_8d063c:
	lsr_s r1,r1,0x3
L_8d063e:
	bic r1,r1,0x3
L_8d0642:
	st_s r14,[r1]
L_8d0644:
	add r1,mlo,0x44099c0
L_8d064c:
	lsr r2,r1,0x3
L_8d0650:
	bic r3,r2,0x3
L_8d0654:
	ld_s r2,[r3]
L_8d0656:
	bmsk_s r1,r1,0x4
L_8d0658:
	mov_s r14,0x0
L_8d065a:
	bset r14,r14,r1
L_8d065e:
	bic_s r2,r2,r14
L_8d0660:
	or_s r2,r2,r14
L_8d0662:
	st_s r2,[r3]
L_8d0664:
	asl r1,r16,0x10
L_8d0668:
	and r1,r1,0x1f0000
L_8d0670:
	or r1,r1,0xf
L_8d0674:
	add r0,mlo,0x44096c0
L_8d067c:
	lsr_s r0,r0,0x3
L_8d067e:
	st_s r1,[r0]
L_8d0680:
	sync
L_8d0684:
	nop_s
L_8d0686:
	nop_s
L_8d0688:
	nop_s
L_8d068a:
	mul64 r13,0x380
L_8d068e:
	mov_s r1,0x1
L_8d0690:
	add r0,mlo,0x4409700
L_8d0698:
	lsr_s r0,r0,0x3
L_8d069a:
	st_s r1,[r0]
L_8d069c:
	sync
L_8d06a0:
	nop_s
L_8d06a2:
	nop_s
L_8d06a4:
	nop_s
L_8d06a6:
	mul64 r13,0x380
L_8d06aa:
	mov_s r1,0x0
L_8d06ac:
	add r0,mlo,0x4409700
L_8d06b4:
	lsr_s r0,r0,0x3
L_8d06b6:
	st_s r1,[r0]
L_8d06b8:
	sync
L_8d06bc:
	nop_s
L_8d06be:
	nop_s
L_8d06c0:
	nop_s
L_8d06c2:
	mul64 r13,0x380
L_8d06c6:
	asl r0,r16,0x10
L_8d06ca:
	and r0,r0,0x1f0000
L_8d06d2:
	or r1,r0,0x1f
L_8d06d6:
	add r0,mlo,0x44096c0
L_8d06de:
	lsr_s r0,r0,0x3
L_8d06e0:
	st_s r1,[r0]
L_8d06e2:
	sync
L_8d06e6:
	b L_8c0244
L_8d06ea:
	nop_s
