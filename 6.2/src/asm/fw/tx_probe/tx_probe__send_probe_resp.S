/* tx_probe__send_probe_resp @ 0x8f8c8c, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending probe rsp. len %d (%x --> %x)
 * Зовут его: discovery_handle_probe_req
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit3, fw_sysassert_fatal, mgmt_tx__build_probe_resp, tx_api__send_mgmt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_probe__send_probe_resp
tx_probe__send_probe_resp:
	.global L_8f8c8c
L_8f8c8c:
	push_s blink
L_8f8c8e:
	bl.d L_8c01d0
L_8f8c92:
	mov_s r5,r1
L_8f8c94:
	mov_s r16,r0
L_8f8c96:
	mov_s r17,r2
L_8f8c98:
	mov_s r19,r3
L_8f8c9a:
	mov r18,r4
L_8f8c9e:
	mov_s r0,0x0
L_8f8ca0:
	push_s r0
L_8f8ca2:
	mov_s r1,sp
L_8f8ca4:
	mov_s r0,r16
L_8f8ca6:
	mov_s r2,r5
L_8f8ca8:
	mov_s r3,r17
L_8f8caa:
	bl.d L_8e9f74
L_8f8cae:
	mov r4,0x0
L_8f8cb2:
	ld_s r0,[sp,0x0]
L_8f8cb4:
	breq_s r0,0,L_8f8cea
	.global L_8f8cb6
L_8f8cb6:
	mov_s r1,0x10176ac
L_8f8cbc:
	mov_s r0,0x2d
L_8f8cbe:
	ld_s r2,[sp,0x0]
L_8f8cc0:
	mov_s r3,r16
L_8f8cc2:
	bl.d L_8dcd00
L_8f8cc6:
	mov r4,r16
L_8f8cca:
	ldw r4,[sp]
L_8f8cce:
	mov_s r0,r17
L_8f8cd0:
	mov_s r1,r19
L_8f8cd2:
	mov_s r2,0x1
L_8f8cd4:
	mov_s r3,r16
L_8f8cd6:
	mov r5,r18
L_8f8cda:
	bl.d L_8e5874
L_8f8cde:
	mov r6,0x2
L_8f8ce2:
	mov_s r0,0x0
L_8f8ce4:
	b.d L_8c022c
L_8f8ce8:
	add_s sp,sp,0x4
	.global L_8f8cea
L_8f8cea:
	mov_s r0,blink
L_8f8cec:
	mov_s r1,0x1252
L_8f8cf2:
	bl L_8c9b28
L_8f8cf6:
	b_s L_8f8cb6
