/* tx_api__post_tx_payload @ 0x8dca18, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_TX_MGMT_PACKET_EVENTID TX_API::post_tx_payload() 0x%x by blink=0x%x
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/tx_api.h
 * Зовут его: mlme_sm__tx_complete_cb
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit2, fw_sysassert_fatal, operational_if__send_evt
 */
	.section .text.tx_api__post_tx_payload,"ax",@progbits
	.global tx_api__post_tx_payload
tx_api__post_tx_payload:
	.global L_8dca18
L_8dca18:
	push_s blink
L_8dca1a:
	bl L_8c02bc
L_8dca1e:
	sub_s sp,sp,0x8
L_8dca20:
	mov.f r14,r0
L_8dca24:
	mov_s r16,r1
L_8dca26:
	mov_s r13,sp
L_8dca28:
	beq_s L_8dca68
	.global L_8dca2a
L_8dca2a:
	st_s r14,[r13,0x4]
L_8dca2c:
	sub r0,r14,0x1c
L_8dca30:
	st_s r0,[r13]
L_8dca32:
	ld_s r0,[sp,0x0]
L_8dca34:
	mov r4,blink
L_8dca38:
	ldw_s r13,[r0,0x8]
L_8dca3a:
	mov_s r2,0x1015054
L_8dca40:
	mov_s r0,0x7
L_8dca42:
	mov_s r1,0x2
L_8dca44:
	bl.d L_8edff8
L_8dca48:
	mov_s r3,r14
L_8dca4a:
	mov_s r0,r14
L_8dca4c:
	mov_s r1,0x1841
L_8dca52:
	mov_s r2,r13
L_8dca54:
	mov_s r3,r16
L_8dca56:
	mov r4,0x0
L_8dca5a:
	bl.d L_8e0874
L_8dca5e:
	mov r5,0x1
L_8dca62:
	b.d L_8c0324
L_8dca66:
	add_s sp,sp,0x8
	.global L_8dca68
L_8dca68:
	mov_s r0,blink
L_8dca6a:
	mov_s r2,0x1014d54
L_8dca70:
	mov_s r1,0x11e9
L_8dca76:
	bl.d L_8c82c0
L_8dca7a:
	mov_s r3,0xab
L_8dca7c:
	b_s L_8dca2a
L_8dca7e:
	nop_s
