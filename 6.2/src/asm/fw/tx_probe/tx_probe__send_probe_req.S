/* tx_probe__send_probe_req @ 0x8f8cf8, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending probe req len %d
 * Зовут его: scan_mngr__send_prob_req
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit1, fw_sysassert_fatal, hexdump_words, tx_api__send_mgmt, tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_probe__send_probe_req
tx_probe__send_probe_req:
	.global L_8f8cf8
L_8f8cf8:
	push_s blink
L_8f8cfa:
	bl.d L_8c01d0
L_8f8cfe:
	mov_s r5,r1
L_8f8d00:
	mov_s r16,r0
L_8f8d02:
	mov_s r18,r2
L_8f8d04:
	mov_s r17,r3
L_8f8d06:
	mov r19,r4
L_8f8d0a:
	mov_s r0,0x0
L_8f8d0c:
	push_s r0
L_8f8d0e:
	mov_s r1,sp
L_8f8d10:
	mov_s r0,r16
L_8f8d12:
	mov_s r2,r5
L_8f8d14:
	mov_s r3,r18
L_8f8d16:
	bl.d L_8ea054
L_8f8d1a:
	mov r4,r17
L_8f8d1e:
	ld_s r0,[sp,0x0]
L_8f8d20:
	breq_s r0,0,L_8f8d66
	.global L_8f8d22
L_8f8d22:
	mov_s r1,0x1017690
L_8f8d28:
	mov_s r0,0x2d
L_8f8d2a:
	bl.d L_8dcc10
L_8f8d2e:
	ld_s r2,[sp,0x0]
L_8f8d30:
	mov_s r0,r16
L_8f8d32:
	bl.d L_8c9790
L_8f8d36:
	ld_s r1,[sp,0x0]
L_8f8d38:
	mov_s r0,r18
L_8f8d3a:
	ldw r4,[sp]
L_8f8d3e:
	mov_s r2,0x1
L_8f8d40:
	ld r1,[r17, 0x10]
L_8f8d44:
	mov_s r3,r16
L_8f8d46:
	mov r5,r19
L_8f8d4a:
	bl.d L_8e5874
L_8f8d4e:
	mov r6,0x0
L_8f8d52:
	mov_s r1,0x843158
L_8f8d58:
	ld_s r0,[r1,0x4]
L_8f8d5a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f8d5c:
	st_s r0,[r1,0x4]
L_8f8d5e:
	mov_s r0,0x0
L_8f8d60:
	b.d L_8c022c
L_8f8d64:
	add_s sp,sp,0x4
	.global L_8f8d66
L_8f8d66:
	mov_s r0,blink
L_8f8d68:
	mov_s r1,0x1251
L_8f8d6e:
	bl L_8c9b28
L_8f8d72:
	b_s L_8f8d22
