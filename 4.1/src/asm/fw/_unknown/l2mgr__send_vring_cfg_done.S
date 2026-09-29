/* l2mgr__send_vring_cfg_done @ 0x8f0b8c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_VRING_CFG_DONE_EVENTID for devid %d.
 * Зовут его: STREAM_MGR__2, STREAM_MGR__ADD, encap_trans_type, stream_mgr__add_bcast_vring
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit1, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_vring_cfg_done,"ax",@progbits
	.global l2mgr__send_vring_cfg_done
l2mgr__send_vring_cfg_done:
	.global L_8f0b8c
L_8f0b8c:
	push_s blink
L_8f0b8e:
	bl L_8c02b8
L_8f0b92:
	mov_s r14,r0
L_8f0b94:
	mov_s r15,r1
L_8f0b96:
	mov_s r16,r2
L_8f0b98:
	bl.d L_8c2b68
L_8f0b9c:
	mov_s r17,r3
L_8f0b9e:
	mov_s r13,r0
L_8f0ba0:
	st_s r15,[r0,0x4]
L_8f0ba2:
	stb_s r14,[r0]
L_8f0ba4:
	stb r16,[r0, 0x1]
L_8f0ba8:
	mov_s r2,0x100ca20
L_8f0bae:
	mov_s r0,0xb
L_8f0bb0:
	mov_s r1,0x2
L_8f0bb2:
	bl.d L_8edfcc
L_8f0bb6:
	mov_s r3,r17
L_8f0bb8:
	mov_s r0,r13
L_8f0bba:
	mov_s r1,0x1821
L_8f0bc0:
	mov_s r2,0x8
L_8f0bc2:
	mov_s r3,r17
L_8f0bc4:
	mov r4,0x0
L_8f0bc8:
	bl.d L_8e0874
L_8f0bcc:
	mov r5,r4
L_8f0bd0:
	b L_8c031c
