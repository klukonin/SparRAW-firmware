/* mlme_sm__send_disassoc @ 0x8ee7fc, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Send DISASSOC request  len %d
 *   mlme_sm.cpp
 * Зовут его: mlme_sm__association_timeout_ev_handle, mlme_sm__disconnect_ev_handle
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_sysassert_fatal, log_hexdump, tx_api__send_mgmt, tx_mgmt_srvs__build_disassoc
 */
	.section .text.mlme_sm__send_disassoc,"ax",@progbits
	.global mlme_sm__send_disassoc
mlme_sm__send_disassoc:
	.global L_8ee7fc
L_8ee7fc:
	push_s blink
L_8ee7fe:
	bl L_8c02bc
L_8ee802:
	mov_s r13,r0
L_8ee804:
	mov_s r15,r1
L_8ee806:
	mov_s r16,r2
L_8ee808:
	mov_s r0,0x0
L_8ee80a:
	bl.d L_8c2c80
L_8ee80e:
	push_s r0
L_8ee810:
	mov.f r14,r0
L_8ee814:
	beq_s L_8ee85e
	.global L_8ee816
L_8ee816:
	ld_s r3,[r13,0x3c]
L_8ee818:
	mov_s r1,sp
L_8ee81a:
	extw r4,r15
L_8ee81e:
	mov_s r0,r14
L_8ee820:
	bl.d L_8e4c04
L_8ee824:
	ld_s r2,[r3,0xc]
L_8ee826:
	ld_s r0,[sp,0x0]
L_8ee828:
	breq_s r0,0,L_8ee876
	.global L_8ee82a
L_8ee82a:
	mov_s r2,0x100f3c0
L_8ee830:
	mov_s r0,0xa
L_8ee832:
	mov_s r1,0x2
L_8ee834:
	bl.d L_8edfcc
L_8ee838:
	ld_s r3,[sp,0x0]
L_8ee83a:
	mov_s r0,r14
L_8ee83c:
	bl.d L_8c7f90
L_8ee840:
	ld_s r1,[sp,0x0]
L_8ee842:
	mov_s r1,0x0
L_8ee844:
	ldw r4,[sp]
L_8ee848:
	mov_s r2,0x1
L_8ee84a:
	ld_s r0,[r13,0x3c]
L_8ee84c:
	mov_s r3,r14
L_8ee84e:
	mov r5,r16
L_8ee852:
	bl.d L_8e0c44
L_8ee856:
	mov_s r6,r1
L_8ee858:
	b.d L_8c0324
L_8ee85c:
	add_s sp,sp,0x4
	.global L_8ee85e
L_8ee85e:
	mov_s r0,blink
L_8ee860:
	mov_s r2,0x100f220
L_8ee866:
	mov_s r1,0x1201
L_8ee86c:
	bl.d L_8c82c0
L_8ee870:
	mov r3,0x44e
L_8ee874:
	b_s L_8ee816
	.global L_8ee876
L_8ee876:
	mov_s r0,blink
L_8ee878:
	mov_s r2,0x100f220
L_8ee87e:
	mov_s r1,0x1202
L_8ee884:
	bl.d L_8c82c0
L_8ee888:
	mov r3,0x455
L_8ee88c:
	b_s L_8ee82a
L_8ee88e:
	nop_s
