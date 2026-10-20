/* wmi_rcp_delba @ 0x8ecd1c, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r18_to_r13_ret, __st_r18_to_r13, conn_mgr__by_cid, frame__build_delba, fw_sysassert_fatal, mgmt_tx__begin_frame, mid_list__by_mid_fw, tx_api__send_mgmt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_rcp_delba
wmi_rcp_delba:
	.global L_8ecd1c
L_8ecd1c:
	push_s blink
L_8ecd1e:
	bl L_8c01d4
L_8ecd22:
	mov_s r18,r0
L_8ecd24:
	mov_s r0,0x0
L_8ecd26:
	push_s r0
L_8ecd28:
	bl.d L_8cc3dc
L_8ecd2c:
	mov_s r0,r1
L_8ecd2e:
	mov.f r14,r0
L_8ecd32:
	beq_s L_8ecd98
	.global L_8ecd34
L_8ecd34:
	ldb r0,[r18]
L_8ecd38:
	asr r16,r0,0x4
L_8ecd3c:
	bl.d L_8cbffc
L_8ecd40:
	bmsk_s r0,r0,0x3
L_8ecd42:
	bl.d L_8c3414
L_8ecd46:
	mov_s r15,r0
L_8ecd48:
	mov.f r13,r0
L_8ecd4c:
	mov r17,0xf0
L_8ecd50:
	beq_s L_8ecda4
	.global L_8ecd52
L_8ecd52:
	breq_s r14,0,L_8ecdb0
	.global L_8ecd54
L_8ecd54:
	breq_s r15,0,L_8ecdbc
	.global L_8ecd56
L_8ecd56:
	mov_s r1,sp
L_8ecd58:
	mov_s r0,r13
L_8ecd5a:
	mov_s r2,r14
L_8ecd5c:
	mov_s r3,r15
L_8ecd5e:
	bl.d L_8e9c7c
L_8ecd62:
	mov r4,0xd
L_8ecd66:
	ld_s r0,[sp,0x0]
L_8ecd68:
	mov_s r1,0x0
L_8ecd6a:
	add_s r0,r0,r13
L_8ecd6c:
	and r2,r16,r17
L_8ecd70:
	bl.d L_8f5004
L_8ecd74:
	ldw r3,[r18, 0x2]
L_8ecd78:
	ld_s r14,[sp,0x0]
L_8ecd7a:
	mov_s r1,0x0
L_8ecd7c:
	add_s r14,r14,r0
L_8ecd7e:
	st_s r14,[sp,0x0]
L_8ecd80:
	extw r4,r14
L_8ecd84:
	mov_s r0,r15
L_8ecd86:
	mov_s r2,0x1
L_8ecd88:
	mov_s r3,r13
L_8ecd8a:
	mov_s r5,r1
L_8ecd8c:
	bl.d L_8e5874
L_8ecd90:
	mov_s r6,r1
L_8ecd92:
	b.d L_8c0234
L_8ecd96:
	add_s sp,sp,0x4
	.global L_8ecd98
L_8ecd98:
	mov_s r0,blink
L_8ecd9a:
	mov_s r1,0x6f
L_8ecd9c:
	bl.d L_8c9b28
L_8ecda0:
	bset_s r1,r1,0xc
L_8ecda2:
	b_s L_8ecd34
	.global L_8ecda4
L_8ecda4:
	mov_s r0,blink
L_8ecda6:
	mov_s r1,0x70
L_8ecda8:
	bl.d L_8c9b28
L_8ecdac:
	bset_s r1,r1,0xc
L_8ecdae:
	b_s L_8ecd52
	.global L_8ecdb0
L_8ecdb0:
	mov_s r0,blink
L_8ecdb2:
	mov_s r1,0x71
L_8ecdb4:
	bl.d L_8c9b28
L_8ecdb8:
	bset_s r1,r1,0xc
L_8ecdba:
	b_s L_8ecd54
	.global L_8ecdbc
L_8ecdbc:
	mov_s r0,blink
L_8ecdbe:
	mov_s r1,0x72
L_8ecdc0:
	bl.d L_8c9b28
L_8ecdc4:
	bset_s r1,r1,0xc
L_8ecdc6:
	b_s L_8ecd56
