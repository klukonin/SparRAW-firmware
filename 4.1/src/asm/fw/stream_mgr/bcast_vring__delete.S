/* bcast_vring__delete @ 0x8c7884, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   STARTED DELETE BCAST VRING. Vring: %d, Pring: %d
 *   stream_mgr.cpp
 * Зовут его: encap_trans_type, l2_mgr__pcp_stop, wmi_handler_bcast_vring_cfg
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit2, fw_sysassert_fatal, ul_stream__ba_sm_evt
 */
	.section .text.bcast_vring__delete,"ax",@progbits
	.global bcast_vring__delete
bcast_vring__delete:
	.global L_8c7884
L_8c7884:
	push_s blink
L_8c7886:
	bl L_8c02bc
L_8c788a:
	brhs.d r0,0xa,L_8c78d4
L_8c788e:
	mov_s r15,r0
	.global L_8c7890
L_8c7890:
	mov_s r0,0x8485dc
L_8c7896:
	sub3 r0,r0,0x100
L_8c789a:
	add2_s r0,r0,r15
L_8c789c:
	ld r13,[r0,0x818]
L_8c78a4:
	breq_s r13,0,L_8c78fe
L_8c78a6:
	ld_s r1,[r13,0xc]
L_8c78a8:
	mov r16,0x1
L_8c78ac:
	add3 r14,r13,0x10
L_8c78b0:
	mov_s r0,0x0
L_8c78b2:
	breq_s r1,0,L_8c78ea
L_8c78b4:
	mov_s r2,0x100e8bc
L_8c78ba:
	mov_s r0,0xb
L_8c78bc:
	mov_s r1,0x2
L_8c78be:
	mov_s r3,r15
L_8c78c0:
	bl.d L_8edff8
L_8c78c4:
	mov r4,0x1
L_8c78c8:
	st r16,[r14, 0x44]
L_8c78cc:
	mov_s r0,r13
L_8c78ce:
	mov_s r1,0x6
L_8c78d0:
	mov_s r2,0x24
L_8c78d2:
	b_s L_8c78f6
	.global L_8c78d4
L_8c78d4:
	mov_s r0,blink
L_8c78d6:
	mov_s r2,0x100e398
L_8c78dc:
	mov_s r1,0x1478
L_8c78e2:
	bl.d L_8c82c0
L_8c78e6:
	mov_s r3,0xaf
L_8c78e8:
	b_s L_8c7890
	.global L_8c78ea
L_8c78ea:
	st_s r0,[r14,0x40]
L_8c78ec:
	st r16,[r14, 0x44]
L_8c78f0:
	mov_s r0,r13
L_8c78f2:
	mov_s r1,r16
L_8c78f4:
	mov_s r2,0x25
	.global L_8c78f6
L_8c78f6:
	mov_s r3,0x0
L_8c78f8:
	bl.d L_8d6afc
L_8c78fc:
	mov_s r4,r3
	.global L_8c78fe
L_8c78fe:
	b L_8c0324
L_8c7902:
	nop_s
