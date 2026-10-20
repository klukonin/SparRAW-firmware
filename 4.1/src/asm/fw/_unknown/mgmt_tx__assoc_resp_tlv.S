/* mgmt_tx__assoc_resp_tlv @ 0x8ec7e0, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ASSOC RESP TLV %d aid %d
 *   ASSOC RESP TLV %d
 * Зовут его: mgmt_tx__build_assoc_resp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit2, fw_log__emit3, ie__push_dmg_capabilities, ie__push_edca, ie__push_eid151_len10, ie__push_qos_capability
 */
	.section .text.mgmt_tx__assoc_resp_tlv,"ax",@progbits
	.global mgmt_tx__assoc_resp_tlv
mgmt_tx__assoc_resp_tlv:
	.global L_8ec7e0
L_8ec7e0:
	push_s blink
L_8ec7e2:
	bl.d L_8c02bc
L_8ec7e6:
	extb_s r2,r3
L_8ec7e8:
	mov_s r13,r0
L_8ec7ea:
	mov_s r14,r1
L_8ec7ec:
	mov_s r15,r3
L_8ec7ee:
	add_s r1,r1,0x5e
L_8ec7f0:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8ec7f2:
	bl.d L_8ef87c
L_8ec7f6:
	extb_s r2,r2
L_8ec7f8:
	extw r16,r0
L_8ec7fc:
	mov_s r2,0x100c0f0
L_8ec802:
	add r5,r15,0x1
L_8ec806:
	mov_s r0,0xd
L_8ec808:
	mov_s r1,0x2
L_8ec80a:
	mov_s r3,0x94
L_8ec80c:
	bl.d L_8ee034
L_8ec810:
	mov r4,r16
L_8ec814:
	add_s r13,r13,r16
L_8ec816:
	add3 r1,r14,0x1f
L_8ec81a:
	bl.d L_8ef864
L_8ec81e:
	mov_s r0,r13
L_8ec820:
	extw_s r0,r0
L_8ec822:
	add_s r13,r13,r0
L_8ec824:
	add r15,r16,r0
L_8ec828:
	extw_s r15,r15
L_8ec82a:
	mov_s r0,r13
L_8ec82c:
	bl.d L_8ef7b8
L_8ec830:
	mov_s r1,r14
L_8ec832:
	extw_s r0,r0
L_8ec834:
	add_s r13,r13,r0
L_8ec836:
	add_s r15,r15,r0
L_8ec838:
	extw_s r15,r15
L_8ec83a:
	bl.d L_8ef804
L_8ec83e:
	mov_s r0,r13
L_8ec840:
	extw r4,r0
L_8ec844:
	add_s r15,r15,r4
L_8ec846:
	extw_s r15,r15
L_8ec848:
	mov_s r2,0x100c10c
L_8ec84e:
	mov_s r0,0xd
L_8ec850:
	mov_s r1,0x2
L_8ec852:
	bl.d L_8edff8
L_8ec856:
	mov_s r3,0xdd
L_8ec858:
	b.d L_8c0324
L_8ec85c:
	mov_s r0,r15
L_8ec85e:
	nop_s
