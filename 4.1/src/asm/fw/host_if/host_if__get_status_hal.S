/* host_if__get_status_hal @ 0x8ca964, 380 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   *** GET STATUS HAL ***
 *   <mac address: > ADDR-%04X%08X
 *   host_if.cpp
 *   <is_associated:%d>
 *   <cid:%d>
 *   <bssid: 0x%x%x%x>
 *   <channel:%d>
 *   <network_type:%d>
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, memset0_words, mid__conn_state_ne_1, mid__copy_bssid
 */
	.section .text.host_if__get_status_hal,"ax",@progbits
	.global host_if__get_status_hal
host_if__get_status_hal:
	.global L_8ca964
L_8ca964:
	push_s blink
L_8ca966:
	bl.d L_8c02b0
L_8ca96a:
	mov_s r1,0x2
L_8ca96c:
	mov_s r19,r0
L_8ca96e:
	mov_s r18,r2
L_8ca970:
	mov_s r2,0x1006230
L_8ca976:
	bl.d L_8edfb0
L_8ca97a:
	mov_s r0,0x5
L_8ca97c:
	bl.d L_8c2c38
L_8ca980:
	mov_s r0,r19
L_8ca982:
	mov_s r13,r0
L_8ca984:
	bl.d L_8c1a78
L_8ca988:
	mov_s r1,0x40
L_8ca98a:
	bl.d L_8ca1b0
L_8ca98e:
	mov_s r0,r18
L_8ca990:
	mov.f r14,r0
L_8ca994:
	beq_s L_8ca9f6
	.global L_8ca996
L_8ca996:
	add r3,r14,0xa
L_8ca99a:
	mov_s r2,0x1006248
L_8ca9a0:
	ld r4,[r3]
L_8ca9a4:
	mov_s r0,0xb
L_8ca9a6:
	mov_s r1,0x2
L_8ca9a8:
	bl.d L_8edff8
L_8ca9ac:
	ldw_s r3,[r3,0x4]
L_8ca9ae:
	mov_s r0,r14
L_8ca9b0:
	mov_s r1,0x1
L_8ca9b2:
	bl.d L_8ca1f8
L_8ca9b6:
	mov_s r16,r1
L_8ca9b8:
	mov.f r17,r0
L_8ca9bc:
	beq_s L_8caa0c
L_8ca9be:
	st r16,[r13]
L_8ca9c2:
	ldb r0,[r17, 0x8]
L_8ca9c6:
	add3 r15,r14,0x9
L_8ca9ca:
	stb_s r0,[r13,0x4]
L_8ca9cc:
	ldb r0,[r15, 0x4c]
L_8ca9d0:
	add r1,r13,0x8
L_8ca9d4:
	stb_s r0,[r13,0xe]
L_8ca9d6:
	ld_s r0,[r14,0x14]
L_8ca9d8:
	stb_s r0,[r13,0x10]
L_8ca9da:
	bl.d L_8c9ae4
L_8ca9de:
	mov_s r0,r15
L_8ca9e0:
	add r1,r13,0x18
L_8ca9e4:
	bl.d L_8ca928
L_8ca9e8:
	mov_s r0,r15
L_8ca9ea:
	st_s r0,[r13,0x14]
L_8ca9ec:
	bl.d L_8ed820
L_8ca9f0:
	mov_s r0,r17
L_8ca9f2:
	st_s r0,[r13,0x3c]
L_8ca9f4:
	b_s L_8caa10
	.global L_8ca9f6
L_8ca9f6:
	mov_s r0,blink
L_8ca9f8:
	mov_s r2,0x1006224
L_8ca9fe:
	mov_s r1,0x40
L_8caa00:
	bset_s r1,r1,0xc
L_8caa02:
	bl.d L_8c82c0
L_8caa06:
	mov r3,0x319
L_8caa0a:
	b_s L_8ca996
	.global L_8caa0c
L_8caa0c:
	mov_s r0,0x0
L_8caa0e:
	st_s r0,[r13]
	.global L_8caa10
L_8caa10:
	bl L_8ca800
L_8caa14:
	breq_s r0,0,L_8caa38
L_8caa16:
	breq r0,0x1,L_8caa3c
L_8caa1a:
	breq r0,0x2,L_8caa40
L_8caa1e:
	breq r0,0x3,L_8caa44
L_8caa22:
	mov_s r0,blink
L_8caa24:
	mov_s r2,0x1006224
L_8caa2a:
	mov_s r1,0x41
L_8caa2c:
	bset_s r1,r1,0xc
L_8caa2e:
	bl.d L_8c82c0
L_8caa32:
	mov r3,0x346
L_8caa36:
	b_s L_8caa48
	.global L_8caa38
L_8caa38:
	mov_s r0,0x0
L_8caa3a:
	b_s L_8caa46
	.global L_8caa3c
L_8caa3c:
	mov_s r0,0x1
L_8caa3e:
	b_s L_8caa46
	.global L_8caa40
L_8caa40:
	mov_s r0,0x2
L_8caa42:
	b_s L_8caa46
	.global L_8caa44
L_8caa44:
	mov_s r0,0x3
	.global L_8caa46
L_8caa46:
	st_s r0,[r13,0x38]
	.global L_8caa48
L_8caa48:
	mov_s r2,0x1006268
L_8caa4e:
	mov_s r0,0x5
L_8caa50:
	mov_s r1,0x2
L_8caa52:
	bl.d L_8edfcc
L_8caa56:
	ld_s r3,[r13]
L_8caa58:
	mov_s r2,0x100627c
L_8caa5e:
	mov_s r0,0x5
L_8caa60:
	mov_s r1,0x2
L_8caa62:
	bl.d L_8edfcc
L_8caa66:
	ldb_s r3,[r13,0x4]
L_8caa68:
	mov_s r2,0x1006288
L_8caa6e:
	ldb r4,[r13, 0x9]
L_8caa72:
	mov_s r0,0x5
L_8caa74:
	ldb r5,[r13, 0xa]
L_8caa78:
	mov_s r1,0x2
L_8caa7a:
	bl.d L_8ee034
L_8caa7e:
	ldb_s r3,[r13,0x8]
L_8caa80:
	mov_s r2,0x100629c
L_8caa86:
	mov_s r0,0x5
L_8caa88:
	mov_s r1,0x2
L_8caa8a:
	bl.d L_8edfcc
L_8caa8e:
	ldb_s r3,[r13,0xe]
L_8caa90:
	mov_s r2,0x10062ac
L_8caa96:
	mov_s r0,0x5
L_8caa98:
	mov_s r1,0x2
L_8caa9a:
	bl.d L_8edfcc
L_8caa9e:
	ldb_s r3,[r13,0x10]
L_8caaa0:
	mov_s r2,0x10062c0
L_8caaa6:
	mov_s r0,0x5
L_8caaa8:
	mov_s r1,0x2
L_8caaaa:
	bl.d L_8edfcc
L_8caaae:
	ld_s r3,[r13,0x14]
L_8caab0:
	mov_s r2,0x10062d0
L_8caab6:
	mov_s r0,0x5
L_8caab8:
	mov_s r1,0x2
L_8caaba:
	bl.d L_8edfcc
L_8caabe:
	ld_s r3,[r13,0x38]
L_8caac0:
	mov_s r0,r19
L_8caac2:
	mov_s r1,r13
L_8caac4:
	mov_s r2,0x0
L_8caac6:
	mov_s r3,0x1864
L_8caacc:
	mov r4,0x40
L_8caad0:
	mov r5,r18
L_8caad4:
	mov_s r6,r2
L_8caad6:
	bl.d L_8e0460
L_8caada:
	mov_s r7,r2
L_8caadc:
	b L_8c030c
