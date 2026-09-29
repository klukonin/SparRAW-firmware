/* wmi_handler_bcast_vring_cfg @ 0x8f2bac, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   layer2_mgr.cpp
 *   BCAST NEW VRING: %d
 *   TX max_msdu_size = %d
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bcast_vring__delete, fw_log__emit1, fw_sysassert_fatal, init_bcast_queue, mid__setup_bcast_vring, mid__type_of, mid_list__by_mid, stream_mgr__add_bcast_vring, stream_mgr__alloc_pring
 */
	.section .text.wmi_handler_bcast_vring_cfg,"ax",@progbits
	.global wmi_handler_bcast_vring_cfg
wmi_handler_bcast_vring_cfg:
	.global L_8f2bac
L_8f2bac:
	push_s blink
L_8f2bae:
	bl L_8c02b4
L_8f2bb2:
	ldb_s r14,[r0,0x10]
L_8f2bb4:
	mov_s r13,r0
L_8f2bb6:
	sub_s sp,sp,0x10
L_8f2bb8:
	brhs.d r14,0xa,L_8f2bd2
L_8f2bbc:
	mov_s r16,r1
L_8f2bbe:
	ld_s r0,[r13]
L_8f2bc0:
	breq_s r0,0,L_8f2bfe
L_8f2bc2:
	breq r0,0x1,L_8f2be6
L_8f2bc6:
	brne r0,0x2,L_8f2be6
L_8f2bca:
	bl.d L_8c7884
L_8f2bce:
	mov_s r0,r14
L_8f2bd0:
	b_s L_8f2c66
	.global L_8f2bd2
L_8f2bd2:
	mov_s r0,blink
L_8f2bd4:
	mov_s r2,0x100c474
L_8f2bda:
	mov_s r1,0x11f6
L_8f2be0:
	mov r3,0x290
L_8f2be4:
	b_s L_8f2bf8
	.global L_8f2be6
L_8f2be6:
	mov_s r0,blink
L_8f2be8:
	mov_s r2,0x100c474
L_8f2bee:
	mov_s r1,0x11dc
L_8f2bf4:
	mov r3,0x2b1
	.global L_8f2bf8
L_8f2bf8:
	bl L_8c82c0
L_8f2bfc:
	b_s L_8f2c66
	.global L_8f2bfe
L_8f2bfe:
	mov_s r2,0x100cbf8
L_8f2c04:
	mov_s r0,0xb
L_8f2c06:
	mov_s r1,0x2
L_8f2c08:
	bl.d L_8edfcc
L_8f2c0c:
	mov_s r3,r14
L_8f2c0e:
	bl L_8c2d04
L_8f2c12:
	mov_s r2,0x100cc0c
L_8f2c18:
	mov_s r17,r0
L_8f2c1a:
	ldw_s r15,[r13,0xe]
L_8f2c1c:
	mov_s r0,0xb
L_8f2c1e:
	mov_s r1,0x2
L_8f2c20:
	bl.d L_8edfcc
L_8f2c24:
	mov_s r3,r15
L_8f2c26:
	bl.d L_8ca1b0
L_8f2c2a:
	mov_s r0,r16
L_8f2c2c:
	mov_s r18,r0
L_8f2c2e:
	mov_s r0,r15
L_8f2c30:
	bl.d L_8d6674
L_8f2c34:
	mov_s r1,r14
L_8f2c36:
	mov_s r15,0x1
L_8f2c38:
	bl.d L_8cabe4
L_8f2c3c:
	mov_s r0,r18
L_8f2c3e:
	ldb r5,[r13, 0x11]
L_8f2c42:
	st_s r15,[sp,0x0]
L_8f2c44:
	st_s r0,[sp,0x4]
L_8f2c46:
	st r16,[sp, 0x8]
L_8f2c4a:
	st_s r15,[sp,0xc]
L_8f2c4c:
	mov_s r0,r17
L_8f2c4e:
	mov_s r1,r14
L_8f2c50:
	mov_s r2,0x0
L_8f2c52:
	mov_s r3,r2
L_8f2c54:
	mov_s r4,r2
L_8f2c56:
	mov_s r6,r2
L_8f2c58:
	bl.d L_8e1360
L_8f2c5c:
	mov_s r7,r2
L_8f2c5e:
	add_s r1,r13,0x4
L_8f2c60:
	bl.d L_8c2138
L_8f2c64:
	mov_s r0,r17
	.global L_8f2c66
L_8f2c66:
	b.d L_8c0314
L_8f2c6a:
	add_s sp,sp,0x10
