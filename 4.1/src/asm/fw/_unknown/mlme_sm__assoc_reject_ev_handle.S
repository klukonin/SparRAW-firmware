/* mlme_sm__assoc_reject_ev_handle @ 0x8e9710, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ASSOC REJECT event.
 *   mlme_sm::assoc_reject_ev_handle()  remove_request 0x%x ,locked: 0x%x
 *   MLME_UNLOCK_RADIO - unlocking radio 0x%x
 *   MLME_UNLOCK_RADIO - remove request 0x%x
 * Зовёт сам: RADIO_MGR__remove_request, RADIO_MGR__unlock, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit2, mgmt_pkt__release, mlme_notify, u_schd__cancel
 */
	.section .text.mlme_sm__assoc_reject_ev_handle,"ax",@progbits
	.global mlme_sm__assoc_reject_ev_handle
mlme_sm__assoc_reject_ev_handle:
L_8e9710:
	push_s blink
L_8e9712:
	bl L_8c02c0
L_8e9716:
	mov_s r14,r0
L_8e9718:
	mov_s r13,r1
L_8e971a:
	mov_s r2,0x100f560
L_8e9720:
	mov_s r0,0xa
L_8e9722:
	bl.d L_8edfb0
L_8e9726:
	mov_s r1,0x2
L_8e9728:
	ld_s r0,[r14,0x38]
L_8e972a:
	mov_s r15,0x0
L_8e972c:
	breq_s r0,0,L_8e9734
L_8e972e:
	bl L_8c7794
L_8e9732:
	st_s r15,[r14,0x38]
	.global L_8e9734
L_8e9734:
	mov_s r2,0x100f574
L_8e973a:
	ld r4,[r14, 0x2c]
L_8e973e:
	mov_s r0,0x0
L_8e9740:
	mov_s r1,0x2
L_8e9742:
	bl.d L_8edff8
L_8e9746:
	ld_s r3,[r14,0x34]
L_8e9748:
	ld_s r3,[r14,0x34]
L_8e974a:
	breq_s r3,0,L_8e977a
L_8e974c:
	ld_s r0,[r14,0x2c]
L_8e974e:
	breq_s r0,0,L_8e9766
L_8e9750:
	mov_s r2,0x100f448
L_8e9756:
	mov_s r0,0xc
L_8e9758:
	bl.d L_8edfcc
L_8e975c:
	mov_s r1,0x2
L_8e975e:
	bl.d L_8e54d8
L_8e9762:
	ld_s r0,[r14,0x34]
L_8e9764:
	b_s L_8e977a
	.global L_8e9766
L_8e9766:
	mov_s r2,0x100f474
L_8e976c:
	mov_s r0,0xc
L_8e976e:
	bl.d L_8edfcc
L_8e9772:
	mov_s r1,0x2
L_8e9774:
	bl.d L_8de444
L_8e9778:
	ld_s r0,[r14,0x34]
	.global L_8e977a
L_8e977a:
	st_s r15,[r14,0x34]
L_8e977c:
	ld_s r0,[r14,0x3c]
L_8e977e:
	st_s r15,[r14,0x2c]
L_8e9780:
	ld_s r0,[r0,0xc]
L_8e9782:
	ld_s r0,[r0,0x50]
L_8e9784:
	cmp_s r0,0x1
L_8e9786:
	mov_s r0,0x1
L_8e9788:
	sub_s.ne r0,r0,r0
L_8e978a:
	extb.f 0x0,r0
L_8e978e:
	cmp.ne r13,0x0
L_8e9792:
	beq_s L_8e979c
L_8e9794:
	st_s r13,[r14,0x48]
L_8e9796:
	bl.d L_8c955c
L_8e979a:
	mov_s r0,r13
	.global L_8e979c
L_8e979c:
	ld_s r1,[r14,0x3c]
L_8e979e:
	mov_s r0,r14
L_8e97a0:
	ldb_s r1,[r1,0x8]
L_8e97a2:
	mov_s r2,0x1
L_8e97a4:
	mov_s r3,0x5
L_8e97a6:
	bl.d L_8da490
L_8e97aa:
	mov r4,0x0
L_8e97ae:
	.byte 0x81,0x03
