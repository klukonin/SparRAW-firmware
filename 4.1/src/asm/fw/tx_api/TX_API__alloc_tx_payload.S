/* TX_API__alloc_tx_payload @ 0x8c2c80, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::alloc_tx_payload mem pool allocation failed assigning fw_tx_packet_error_buffer (tx_status=0x%x)
 *   tx_api.cpp
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/tx_api.h
 * Зовут его: add_discovery_bcon, ba__send_addba_resp, ba_sm__send_addba_req, ba_sm__send_delba, discovery_handle_probe_req, ese_cfg__apply, find_main_sm__bf_ntf, find_main_sm__probe_req, find_main_sm__probe_req_in_search, l2mgr__set_app_ie
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, fw_sysassert_fatal, mem_pool__allocate, memset0_words
 */
	.section .text.TX_API__alloc_tx_payload,"ax",@progbits
	.global TX_API__alloc_tx_payload
TX_API__alloc_tx_payload:
	.global L_8c2c80
L_8c2c80:
	push_s blink
L_8c2c82:
	bl L_8c02c4
L_8c2c86:
	mov_s r0,0x8425c0
L_8c2c8c:
	bl.d L_8c2dc8
L_8c2c90:
	sub_s sp,sp,0x8
L_8c2c92:
	mov_s r14,sp
L_8c2c94:
	brne_s r0,0,L_8c2cd6
L_8c2c96:
	mov_s r13,0x805da8
L_8c2c9c:
	breq_s r13,0,L_8c2cec
	.global L_8c2c9e
L_8c2c9e:
	st_s r13,[r14]
L_8c2ca0:
	add_s r13,r13,0x1c
L_8c2ca2:
	st_s r13,[r14,0x4]
L_8c2ca4:
	ld_s r3,[sp,0x0]
L_8c2ca6:
	mov_s r2,0x1014fe8
L_8c2cac:
	mov_s r0,0x7
L_8c2cae:
	mov_s r1,0x1
L_8c2cb0:
	bl.d L_8edfcc
L_8c2cb4:
	ldb_s r3,[r3,0x11]
L_8c2cb6:
	ld_s r0,[sp,0x0]
L_8c2cb8:
	ldb_s r0,[r0,0x11]
L_8c2cba:
	cmp r0,0xfd
L_8c2cbe:
	beq_s L_8c2cda
L_8c2cc0:
	mov_s r0,blink
L_8c2cc2:
	mov_s r2,0x1014cd4
L_8c2cc8:
	mov_s r1,0x134c
L_8c2cce:
	bl.d L_8c82c0
L_8c2cd2:
	mov_s r3,0x99
L_8c2cd4:
	b_s L_8c2cda
	.global L_8c2cd6
L_8c2cd6:
	add_s r0,r0,0x1c
L_8c2cd8:
	st_s r0,[sp,0x4]
	.global L_8c2cda
L_8c2cda:
	ld_s r0,[sp,0x4]
L_8c2cdc:
	bl.d L_8c1a78
L_8c2ce0:
	mov r1,0x500
L_8c2ce4:
	ld_s r0,[sp,0x4]
L_8c2ce6:
	b.d L_8c0334
L_8c2cea:
	add_s sp,sp,0x8
	.global L_8c2cec
L_8c2cec:
	mov_s r0,blink
L_8c2cee:
	mov_s r2,0x1014d54
L_8c2cf4:
	mov_s r1,0x11d6
L_8c2cfa:
	bl.d L_8c82c0
L_8c2cfe:
	mov_s r3,0xaa
L_8c2d00:
	b_s L_8c2c9e
L_8c2d02:
	nop_s
