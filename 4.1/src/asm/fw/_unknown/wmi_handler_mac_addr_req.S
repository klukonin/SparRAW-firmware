/* wmi_handler_mac_addr_req @ 0x8e77f8, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MAC ADDR-%04X%08X
 *   auth_mode=%d, crypt_mode=%d, offload_mode=%d
 *   <<---- [HOST EVENT] WMI_MAC_ADDR_RESP_EVENTID for devid %d
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit1, fw_log__emit2, fw_log__emit3, memcpy_fw, mid_list__by_mid
 */
	.section .text.wmi_handler_mac_addr_req,"ax",@progbits
	.global wmi_handler_mac_addr_req
wmi_handler_mac_addr_req:
	.global L_8e77f8
L_8e77f8:
	push_s blink
L_8e77fa:
	bl L_8c02bc
L_8e77fe:
	mov_s r15,r0
L_8e7800:
	mov_s r16,r1
L_8e7802:
	bl.d L_8c2c38
L_8e7806:
	mov_s r0,r1
L_8e7808:
	mov_s r13,r0
L_8e780a:
	bl.d L_8ca1b0
L_8e780e:
	mov_s r0,r15
L_8e7810:
	mov_s r14,r0
L_8e7812:
	add r1,r0,0xa
L_8e7816:
	mov_s r0,r13
L_8e7818:
	bl.d L_8c0460
L_8e781c:
	mov_s r2,0x6
L_8e781e:
	add_s r14,r14,0x28
L_8e7820:
	ld_s r0,[r14,0x4]
L_8e7822:
	mov_s r2,0x100a134
L_8e7828:
	stb_s r0,[r13,0x6]
L_8e782a:
	ld_s r0,[r14,0x8]
L_8e782c:
	ld r4,[r13]
L_8e7830:
	stb_s r0,[r13,0x7]
L_8e7832:
	ld_s r0,[r14,0x18]
L_8e7834:
	mov_s r1,0x2
L_8e7836:
	st_s r0,[r13,0x8]
L_8e7838:
	mov_s r0,0x0
L_8e783a:
	bl.d L_8edff8
L_8e783e:
	ldw_s r3,[r13,0x4]
L_8e7840:
	mov_s r2,0x100a148
L_8e7846:
	ldb r4,[r13, 0x7]
L_8e784a:
	mov_s r0,0x0
L_8e784c:
	ld r5,[r13, 0x8]
L_8e7850:
	mov_s r1,0x2
L_8e7852:
	bl.d L_8ee034
L_8e7856:
	ldb_s r3,[r13,0x6]
L_8e7858:
	mov_s r2,0x100a178
L_8e785e:
	mov_s r0,0x0
L_8e7860:
	mov_s r1,0x2
L_8e7862:
	bl.d L_8edfcc
L_8e7866:
	mov_s r3,r15
L_8e7868:
	mov_s r0,r16
L_8e786a:
	mov_s r1,r13
L_8e786c:
	mov_s r2,0x0
L_8e786e:
	mov_s r3,0x9003
L_8e7874:
	mov r4,0xc
L_8e7878:
	mov_s r5,r15
L_8e787a:
	mov r6,0x0
L_8e787e:
	bl.d L_8e0460
L_8e7882:
	mov r7,0x0
L_8e7886:
	b L_8c0324
L_8e788a:
	nop_s
