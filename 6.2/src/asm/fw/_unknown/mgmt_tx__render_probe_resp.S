/* mgmt_tx__render_probe_resp @ 0x8f2b40, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: send_sw_packet
 * Зовёт сам: TX_API__alloc_tx_payload, TX_API__free_memory, __ld_r16_to_r13_ret, __st_r16_to_r13, memcpy_fw, mgmt_tx__build_fixed_probe_resp
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__render_probe_resp
mgmt_tx__render_probe_resp:
	.global L_8f2b40
L_8f2b40:
	push_s blink
L_8f2b42:
	bl L_8c01dc
L_8f2b46:
	sub_s sp,sp,0x4
L_8f2b48:
	mov_s r14,r0
L_8f2b4a:
	mov_s r16,r2
L_8f2b4c:
	bl.d L_8c3414
L_8f2b50:
	mov_s r13,r3
L_8f2b52:
	mov_s r15,r0
L_8f2b54:
	mov_s r0,0x0
L_8f2b56:
	stw r0,[sp]
L_8f2b5a:
	ldw r4,[r13]
L_8f2b5e:
	mov_s r1,sp
L_8f2b60:
	ld_s r2,[r14,0x4]
L_8f2b62:
	mov_s r0,r15
L_8f2b64:
	bl.d L_8ea0d8
L_8f2b68:
	mov_s r3,r16
L_8f2b6a:
	ldw r0,[sp]
L_8f2b6e:
	mov_s r1,r15
L_8f2b70:
	stw_s r0,[r13]
L_8f2b72:
	mov_s r0,r16
L_8f2b74:
	bl.d L_8c0380
L_8f2b78:
	ldw r2,[sp]
L_8f2b7c:
	bl.d L_8cb10c
L_8f2b80:
	mov_s r0,r15
L_8f2b82:
	b.d L_8c0244
L_8f2b86:
	add_s sp,sp,0x4
