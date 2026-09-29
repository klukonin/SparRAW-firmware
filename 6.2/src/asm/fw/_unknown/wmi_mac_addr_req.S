/* wmi_mac_addr_req @ 0x8ec724, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MAC ADDR-%04X%08X
 *   auth_mode=%d, crypt_mode=%d, offload_mode=%d
 *   <<---- [HOST EVENT] WMI_MAC_ADDR_RESP_EVENTID for devid %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_log_emit2, fw_log_emit3, mem_pool__alloc_locked, memcpy_fw, mid_list__by_mid_fw, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_mac_addr_req
wmi_mac_addr_req:
	.global L_8ec724
L_8ec724:
	push_s blink
L_8ec726:
	bl L_8c01dc
L_8ec72a:
	sub_s sp,sp,0x4
L_8ec72c:
	mov_s r15,r0
L_8ec72e:
	mov_s r16,r1
L_8ec730:
	bl.d L_8c33d0
L_8ec734:
	mov_s r0,r1
L_8ec736:
	mov_s r13,r0
L_8ec738:
	bl.d L_8cc3dc
L_8ec73c:
	mov_s r0,r15
L_8ec73e:
	mov_s r14,r0
L_8ec740:
	add r1,r0,0xa
L_8ec744:
	mov_s r0,r13
L_8ec746:
	bl.d L_8c0380
L_8ec74a:
	mov_s r2,0x6
L_8ec74c:
	add_s r14,r14,0x28
L_8ec74e:
	ld_s r0,[r14,0x4]
L_8ec750:
	mov_s r1,0x100b6e0
L_8ec756:
	stb_s r0,[r13,0x6]
L_8ec758:
	ld_s r0,[r14,0x8]
L_8ec75a:
	ldw_s r2,[r13,0x4]
L_8ec75c:
	stb_s r0,[r13,0x7]
L_8ec75e:
	ld_s r0,[r14,0x18]
L_8ec760:
	st_s r0,[r13,0x8]
L_8ec762:
	mov_s r0,0x20
L_8ec764:
	bl.d L_8dcc80
L_8ec768:
	ld_s r3,[r13]
L_8ec76a:
	mov_s r1,0x100b6f4
L_8ec770:
	ld r4,[r13, 0x8]
L_8ec774:
	mov_s r0,0x20
L_8ec776:
	ldb_s r2,[r13,0x6]
L_8ec778:
	bl.d L_8dcd00
L_8ec77c:
	ldb_s r3,[r13,0x7]
L_8ec77e:
	mov_s r1,0x100b724
L_8ec784:
	mov_s r0,0x20
L_8ec786:
	bl.d L_8dcc10
L_8ec78a:
	mov_s r2,r15
L_8ec78c:
	mov_s r2,0x0
L_8ec78e:
	st_s r2,[sp,0x0]
L_8ec790:
	mov_s r0,r16
L_8ec792:
	mov_s r1,r13
L_8ec794:
	mov_s r3,0x9003
L_8ec79a:
	mov r4,0xc
L_8ec79e:
	mov_s r5,r15
L_8ec7a0:
	mov_s r6,r2
L_8ec7a2:
	bl.d L_8e4fc4
L_8ec7a6:
	mov_s r7,r2
L_8ec7a8:
	b.d L_8c0244
L_8ec7ac:
	add_s sp,sp,0x4
L_8ec7ae:
	nop_s
