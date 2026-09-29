/* vring__configure_tx @ 0x8e6024, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_bcast_vring_cfg, wmi_vring_cfg
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, l2mgr__program_args, mac_enable_bcast_ring, mid__type_of, sm_obj__store_desc, tx_macq__setup_params, vring_hw__clear_tx_ctl_bit0, vring_tbl__entry_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__configure_tx
vring__configure_tx:
	.global L_8e6024
L_8e6024:
	push_s blink
L_8e6026:
	bl.d L_8c01c8
L_8e602a:
	mov r4,0x0
L_8e602e:
	sub_s sp,sp,0xc
L_8e6030:
	mov_s r15,r0
L_8e6032:
	mov_s r19,r1
L_8e6034:
	mov_s r13,r2
L_8e6036:
	mov r18,r5
L_8e603a:
	mov r16,r6
L_8e603e:
	mov r17,r7
L_8e6042:
	ldb r6,[sp, 0x34]
L_8e6046:
	ld_s r14,[sp,0x40]
L_8e6048:
	ld r7,[sp, 0x3c]
L_8e604c:
	st_s r14,[sp,0x0]
L_8e604e:
	bl.d L_8d96c0
L_8e6052:
	mov_s r5,r1
L_8e6054:
	bl.d L_8ccfd8
L_8e6058:
	mov_s r0,r19
L_8e605a:
	mov_s r19,r0
L_8e605c:
	breq_s r14,0,L_8e607c
L_8e605e:
	mov_s r1,0x802450
L_8e6064:
	ld_s r0,[r1]
L_8e6066:
	ldb r4,[sp, 0x38]
L_8e606a:
	st_s r0,[sp,0x4]
L_8e606c:
	ldw_s r0,[r1,0x4]
L_8e606e:
	add_s r1,sp,0x4
L_8e6070:
	stw r0,[sp, 0x8]
L_8e6074:
	mov_s r0,r19
L_8e6076:
	mov_s r2,r1
L_8e6078:
	mov_s r3,0x8
L_8e607a:
	b_s L_8e6096
	.global L_8e607c
L_8e607c:
	ld_s r0,[r13,0x18]
L_8e607e:
	add r21,r13,0x1c
L_8e6082:
	add r20,r0,0xa
L_8e6086:
	bl.d L_8ccecc
L_8e608a:
	ldb_s r13,[r13,0x8]
L_8e608c:
	mov_s r4,r0
L_8e608e:
	mov_s r0,r19
L_8e6090:
	mov_s r1,r21
L_8e6092:
	mov_s r2,r20
L_8e6094:
	mov_s r3,r13
	.global L_8e6096
L_8e6096:
	bl.d L_8c6c04
L_8e609a:
	mov r5,0xff
L_8e609e:
	cmp r18,0x0
L_8e60a2:
	cmp.ne r18,0x1
L_8e60a6:
	beq_s L_8e60b0
L_8e60a8:
	bl L_8c14d4
L_8e60ac:
	mov_s r1,0x0
L_8e60ae:
	b_s L_8e60b6
	.global L_8e60b0
L_8e60b0:
	bl L_8df5b4
L_8e60b4:
	mov_s r1,0x1
	.global L_8e60b6
L_8e60b6:
	mov_s r0,r19
L_8e60b8:
	mov_s r2,r17
L_8e60ba:
	mov_s r3,r16
L_8e60bc:
	bl.d L_8c6e44
L_8e60c0:
	mov r4,0x0
L_8e60c4:
	mov_s r0,0x1
L_8e60c6:
	stb r0,[r15, 0x5e]
L_8e60ca:
	b.d L_8c021c
L_8e60ce:
	add_s sp,sp,0xc
