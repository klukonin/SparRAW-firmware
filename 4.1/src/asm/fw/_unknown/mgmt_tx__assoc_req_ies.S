/* mgmt_tx__assoc_req_ies @ 0x8ec6f4, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__build_assoc_req
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ie__push_dmg_capabilities, ie__push_qos_capability, ie__push_raw, ie__push_ssid, mid__copy_ssid
 */
	.section .text.mgmt_tx__assoc_req_ies,"ax",@progbits
	.global mgmt_tx__assoc_req_ies
mgmt_tx__assoc_req_ies:
	.global L_8ec6f4
L_8ec6f4:
	push_s blink
L_8ec6f6:
	bl L_8c02c0
L_8ec6fa:
	sub_s sp,sp,0x20
L_8ec6fc:
	mov_s r14,r0
L_8ec6fe:
	mov_s r15,r1
L_8ec700:
	mov_s r13,sp
L_8ec702:
	mov_s r0,r1
L_8ec704:
	bl.d L_8ca928
L_8ec708:
	mov_s r1,r13
L_8ec70a:
	extb_s r2,r0
L_8ec70c:
	mov_s r0,r14
L_8ec70e:
	bl.d L_8ef8dc
L_8ec712:
	mov_s r1,r13
L_8ec714:
	extw_s r13,r0
L_8ec716:
	add_s r14,r14,r13
L_8ec718:
	add3 r1,r15,0x30
L_8ec71c:
	bl.d L_8ef898
L_8ec720:
	mov_s r0,r14
L_8ec722:
	extw.f r0,r0
L_8ec726:
	beq_s L_8ec72e
L_8ec728:
	add_s r14,r14,r0
L_8ec72a:
	add_s r13,r13,r0
L_8ec72c:
	extw_s r13,r13
	.global L_8ec72e
L_8ec72e:
	bl.d L_8ef804
L_8ec732:
	mov_s r0,r14
L_8ec734:
	extw_s r0,r0
L_8ec736:
	add_s r14,r14,r0
L_8ec738:
	add_s r13,r13,r0
L_8ec73a:
	extw_s r13,r13
L_8ec73c:
	add1 r1,r15,0x2f
L_8ec740:
	mov_s r0,r14
L_8ec742:
	bl.d L_8ef87c
L_8ec746:
	mov_s r2,0x0
L_8ec748:
	extw_s r0,r0
L_8ec74a:
	add_s r0,r0,r13
L_8ec74c:
	extw_s r0,r0
L_8ec74e:
	b.d L_8c032c
L_8ec752:
	add_s sp,sp,0x20
