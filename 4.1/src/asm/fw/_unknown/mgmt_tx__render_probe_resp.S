/* mgmt_tx__render_probe_resp @ 0x8eb824, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: send_sw_packet
 * Зовёт сам: TX_API__alloc_tx_payload, TX_API__free_memory, __ld_r16_to_r13_ret, __st_r16_to_r13, memcpy_fw, mgmt_tx__build_fixed_probe_resp
 */
	.section .text.mgmt_tx__render_probe_resp,"ax",@progbits
	.global mgmt_tx__render_probe_resp
mgmt_tx__render_probe_resp:
	.global L_8eb824
L_8eb824:
	push_s blink
L_8eb826:
	bl L_8c02bc
L_8eb82a:
	sub_s sp,sp,0x4
L_8eb82c:
	mov_s r14,r0
L_8eb82e:
	mov_s r16,r2
L_8eb830:
	bl.d L_8c2c80
L_8eb834:
	mov_s r13,r3
L_8eb836:
	mov_s r15,r0
L_8eb838:
	mov_s r0,0x0
L_8eb83a:
	stw r0,[sp]
L_8eb83e:
	ldw r4,[r13]
L_8eb842:
	mov_s r1,sp
L_8eb844:
	ld_s r2,[r14,0x4]
L_8eb846:
	mov_s r0,r15
L_8eb848:
	bl.d L_8e4d0c
L_8eb84c:
	mov_s r3,r16
L_8eb84e:
	ldw r0,[sp]
L_8eb852:
	mov_s r1,r15
L_8eb854:
	stw_s r0,[r13]
L_8eb856:
	mov_s r0,r16
L_8eb858:
	bl.d L_8c0460
L_8eb85c:
	ldw r2,[sp]
L_8eb860:
	bl.d L_8c94c4
L_8eb864:
	mov_s r0,r15
L_8eb866:
	b.d L_8c0324
L_8eb86a:
	add_s sp,sp,0x4
