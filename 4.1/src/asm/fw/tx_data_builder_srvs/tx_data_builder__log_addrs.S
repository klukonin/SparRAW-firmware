/* tx_data_builder__log_addrs @ 0x8e9fc4, 272 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DA ADDR-%04X%08X
 *   SA ADDR-%04X%08X
 *   BSSID ADDR-%04X%08X
 *   ------------------ HDRs len %d ----------------
 *   ------------------ pkt len %d ----------------
 *   -----------------------------------------------
 *   tx_data_builder_srvs.cpp
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_sysassert_fatal, llc_snap__write_header, log_hexdump, memcpy_fw, memset0_words, tx_hdr_build_step
 */
	.section .text.tx_data_builder__log_addrs,"ax",@progbits
	.global tx_data_builder__log_addrs
tx_data_builder__log_addrs:
L_8e9fc4:
	push_s blink
L_8e9fc6:
	bl L_8c02ac
L_8e9fca:
	mov_s r14,r1
L_8e9fcc:
	mov_s r16,r2
L_8e9fce:
	mov_s r15,r3
L_8e9fd0:
	mov_s r1,0x0
L_8e9fd2:
	st_s r1,[r2]
L_8e9fd4:
	ld r20,[r3, 0xc]
L_8e9fd8:
	mov r17,r5
L_8e9fdc:
	mov r19,r4
L_8e9fe0:
	mov r18,r6
L_8e9fe4:
	breq r20,0x0,L_8ea0be
	.global L_8e9fe8
L_8e9fe8:
	mov_s r0,r14
L_8e9fea:
	bl.d L_8c1a78
L_8e9fee:
	mov_s r1,0xc4
L_8e9ff0:
	add r13,r20,0xa
L_8e9ff4:
	mov_s r2,0x1010d28
L_8e9ffa:
	ld.a r4,[r15,0x10]
L_8e9ffe:
	mov_s r0,0xd
L_8ea000:
	mov_s r1,0x2
L_8ea002:
	bl.d L_8edff8
L_8ea006:
	ldw_s r3,[r15,0x4]
L_8ea008:
	mov_s r2,0x1010d3c
L_8ea00e:
	ld r4,[r13]
L_8ea012:
	mov_s r0,0xd
L_8ea014:
	mov_s r1,0x2
L_8ea016:
	bl.d L_8edff8
L_8ea01a:
	ldw_s r3,[r13,0x4]
L_8ea01c:
	mov_s r2,0x1010d50
L_8ea022:
	ld.a r4,[r20,0x54]
L_8ea026:
	mov_s r0,0xd
L_8ea028:
	mov_s r1,0x2
L_8ea02a:
	bl.d L_8edff8
L_8ea02e:
	ldw r3,[r20, 0x4]
L_8ea032:
	mov_s r0,r14
L_8ea034:
	mov_s r1,0x8
L_8ea036:
	mov_s r2,r15
L_8ea038:
	mov_s r3,r13
L_8ea03a:
	mov r4,r20
L_8ea03e:
	mov r5,r19
L_8ea042:
	bl.d L_8ec4f4
L_8ea046:
	mov r6,0x7
L_8ea04a:
	extw_s r0,r0
L_8ea04c:
	mov_s r13,r0
L_8ea04e:
	extw_s r13,r13
L_8ea050:
	add_s r15,r14,r0
L_8ea052:
	mov_s r1,0x888e
L_8ea058:
	bl.d L_8ec598
L_8ea05c:
	mov_s r0,r15
L_8ea05e:
	extw_s r0,r0
L_8ea060:
	add_s r13,r13,r0
L_8ea062:
	extw_s r13,r13
L_8ea064:
	add_s r15,r15,r0
L_8ea066:
	mov_s r2,0x1010d64
L_8ea06c:
	mov_s r0,0xd
L_8ea06e:
	mov_s r1,0x2
L_8ea070:
	bl.d L_8edfcc
L_8ea074:
	mov_s r3,r13
L_8ea076:
	mov_s r0,r14
L_8ea078:
	bl.d L_8c7f90
L_8ea07c:
	mov_s r1,r13
L_8ea07e:
	mov_s r0,r15
L_8ea080:
	mov_s r1,r17
L_8ea082:
	bl.d L_8c0460
L_8ea086:
	mov_s r2,r18
L_8ea088:
	add r3,r13,r18
L_8ea08c:
	extw_s r3,r3
L_8ea08e:
	st r3,[r16]
L_8ea092:
	mov_s r2,0x1010d94
L_8ea098:
	mov_s r0,0xd
L_8ea09a:
	bl.d L_8edfcc
L_8ea09e:
	mov_s r1,0x2
L_8ea0a0:
	mov_s r0,r14
L_8ea0a2:
	bl.d L_8c7f90
L_8ea0a6:
	ld r1,[r16]
L_8ea0aa:
	mov_s r2,0x1010dc4
L_8ea0b0:
	mov_s r0,0xd
L_8ea0b2:
	bl.d L_8edfb0
L_8ea0b6:
	mov_s r1,0x2
L_8ea0b8:
	b.d L_8c0304
L_8ea0bc:
	mov_s r0,0x0
	.global L_8ea0be
L_8ea0be:
	mov_s r0,blink
L_8ea0c0:
	mov_s r2,0x1010df4
L_8ea0c6:
	mov_s r1,0x1184
L_8ea0cc:
	bl.d L_8c82c0
L_8ea0d0:
	mov_s r3,0x6e
L_8ea0d2:
	b_s L_8e9fe8
