/* ieee80211_mgt_information_response_construct @ 0x8ec920, 264 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Send Information Response to ADDR-%04X%08X
 *   ieee80211_mgt_information_response_construct() CID: %d,
 * Зовут его: stream_mgr__send_info_response
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit1, fw_log__emit2, ie__push_dmg_capabilities, ie_list__first, log_hexdump, memcpy_fw, mgmt_tx__begin_frame
 */
	.section .text.ieee80211_mgt_information_response_construct,"ax",@progbits
	.global ieee80211_mgt_information_response_construct
ieee80211_mgt_information_response_construct:
	.global L_8ec920
L_8ec920:
	push_s blink
L_8ec922:
	bl.d L_8c02b0
L_8ec926:
	mov r4,0xd
L_8ec92a:
	mov_s r13,r0
L_8ec92c:
	add r18,r0,0x1
L_8ec930:
	mov_s r17,r1
L_8ec932:
	mov_s r15,r2
L_8ec934:
	mov_s r19,r3
L_8ec936:
	mov_s r0,0x0
L_8ec938:
	mov_s r16,r0
L_8ec93a:
	push_s r0
L_8ec93c:
	add r14,r2,0x10
L_8ec940:
	mov_s r1,sp
L_8ec942:
	mov_s r0,r13
L_8ec944:
	mov_s r2,r17
L_8ec946:
	bl.d L_8e4be4
L_8ec94a:
	mov_s r3,r15
L_8ec94c:
	mov_s r2,0x100c120
L_8ec952:
	ld r4,[r14]
L_8ec956:
	mov_s r0,0xb
L_8ec958:
	mov_s r1,0x2
L_8ec95a:
	bl.d L_8edff8
L_8ec95e:
	ldw_s r3,[r14,0x4]
L_8ec960:
	ld_s r0,[sp,0x0]
L_8ec962:
	mov_s r1,0x10
L_8ec964:
	add_s r0,r0,r13
L_8ec966:
	stb_s r1,[r0]
L_8ec968:
	mov_s r1,0x3
L_8ec96a:
	stb_s r1,[r0,0x1]
L_8ec96c:
	ld_s r0,[sp,0x0]
L_8ec96e:
	mov_s r1,r19
L_8ec970:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8ec972:
	st_s r0,[sp,0x0]
L_8ec974:
	add_s r0,r0,r13
L_8ec976:
	bl.d L_8c0460
L_8ec97a:
	mov_s r2,0x6
L_8ec97c:
	ld_s r0,[sp,0x0]
L_8ec97e:
	mov_s r1,r17
L_8ec980:
	/* add_s r0,0x6 */
	.byte 0x06,0xe0
L_8ec982:
	st_s r0,[sp,0x0]
L_8ec984:
	add r1,r1,0xa6
L_8ec988:
	add_s r0,r0,r13
L_8ec98a:
	bl.d L_8ef87c
L_8ec98e:
	mov_s r2,r16
L_8ec990:
	ld_s r1,[sp,0x0]
L_8ec992:
	add_s r0,r0,r1
L_8ec994:
	st_s r0,[sp,0x0]
L_8ec996:
	ld r0,[r17, 0x50]
L_8ec99a:
	cmp_s r0,0x2
L_8ec99c:
	cmp.ne r0,0x3
L_8ec9a0:
	mov.ne r0,r16
L_8ec9a4:
	bne_s L_8ec9a8
L_8ec9a6:
	mov_s r0,0x1
	.global L_8ec9a8
L_8ec9a8:
	extb.f 0x0,r0
L_8ec9ac:
	beq_s L_8eca02
L_8ec9ae:
	mov_s r15,0x0
L_8ec9b0:
	b_s L_8ec9fe
	.global L_8ec9b2
L_8ec9b2:
	mov_s r0,r17
L_8ec9b4:
	bl.d L_8c9e10
L_8ec9b8:
	mov_s r1,r15
L_8ec9ba:
	mov.f r14,r0
L_8ec9be:
	beq_s L_8ec9fc
L_8ec9c0:
	ldb r0,[r14, 0xb0]
L_8ec9c4:
	brne r0,0x2,L_8ec9fc
L_8ec9c8:
	mov_s r2,0x100c14c
L_8ec9ce:
	mov_s r0,0xb
L_8ec9d0:
	mov_s r1,0x2
L_8ec9d2:
	bl.d L_8edfcc
L_8ec9d6:
	ldb_s r3,[r14,0x8]
L_8ec9d8:
	mov_s r19,r14
L_8ec9da:
	add r19,r19,0x187
L_8ec9de:
	mov_s r0,r19
L_8ec9e0:
	bl.d L_8c7f90
L_8ec9e4:
	mov_s r1,0x13
L_8ec9e6:
	ldb_s r2,[r14,0x8]
L_8ec9e8:
	ld_s r0,[sp,0x0]
L_8ec9ea:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8ec9ec:
	extb_s r2,r2
L_8ec9ee:
	add_s r0,r0,r13
L_8ec9f0:
	bl.d L_8ef87c
L_8ec9f4:
	mov_s r1,r19
L_8ec9f6:
	ld_s r1,[sp,0x0]
L_8ec9f8:
	add_s r0,r0,r1
L_8ec9fa:
	st_s r0,[sp,0x0]
	.global L_8ec9fc
L_8ec9fc:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
	.global L_8ec9fe
L_8ec9fe:
	brlt r15,0x8,L_8ec9b2
	.global L_8eca02
L_8eca02:
	ld_s r1,[sp,0x0]
L_8eca04:
	mov_s r0,0xa
L_8eca06:
	add_s r1,r1,r13
L_8eca08:
	stb_s r0,[r1]
L_8eca0a:
	ld_s r0,[sp,0x0]
L_8eca0c:
	add_s r0,r0,r18
L_8eca0e:
	stb r16,[r0]
L_8eca12:
	ld_s r1,[sp,0x0]
L_8eca14:
	/* add_s r1,0x2 */
	.byte 0x02,0xe1
L_8eca16:
	st_s r1,[sp,0x0]
L_8eca18:
	bl.d L_8c7f90
L_8eca1c:
	mov_s r0,r13
L_8eca1e:
	ld_s r0,[sp,0x0]
L_8eca20:
	b.d L_8c030c
L_8eca24:
	add_s sp,sp,0x4
L_8eca26:
	nop_s
