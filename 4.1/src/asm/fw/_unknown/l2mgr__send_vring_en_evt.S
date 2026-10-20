/* l2mgr__send_vring_en_evt @ 0x8f0bd4, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_VRING_EN_EVENTID for VRING %d.
 * Зовут его: STREAM_MGR__ADD, l2mgr__data_port_open, l2mgr__send_vring_en
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, memset0_words, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_vring_en_evt,"ax",@progbits
	.global l2mgr__send_vring_en_evt
l2mgr__send_vring_en_evt:
	.global L_8f0bd4
L_8f0bd4:
	push_s blink
L_8f0bd6:
	bl L_8c02c0
L_8f0bda:
	mov_s r13,r0
L_8f0bdc:
	bl.d L_8c2b68
L_8f0be0:
	mov_s r15,r1
L_8f0be2:
	mov_s r14,r0
L_8f0be4:
	bl.d L_8c1a78
L_8f0be8:
	mov_s r1,0x4
L_8f0bea:
	stb_s r13,[r14]
L_8f0bec:
	mov_s r2,0x100c624
L_8f0bf2:
	mov_s r0,0xb
L_8f0bf4:
	mov_s r1,0x2
L_8f0bf6:
	bl.d L_8edfcc
L_8f0bfa:
	mov_s r3,r13
L_8f0bfc:
	mov_s r0,r14
L_8f0bfe:
	mov_s r1,0x1865
L_8f0c04:
	mov_s r2,0x4
L_8f0c06:
	mov_s r3,r15
L_8f0c08:
	mov r4,0x0
L_8f0c0c:
	bl.d L_8e0874
L_8f0c10:
	mov r5,r4
L_8f0c14:
	b L_8c032c
