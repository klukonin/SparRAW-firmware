/* find_mngr__detect_discovery_bcon @ 0x8c6d68, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND MNGR: Detect discovery beacon BSSID: %08x%04x discovery_mode=%d.
 * Зовут его: discovery__handle_rx_frame
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, basic_sm__inject_event, find_main_sm__first_detection, fw_log__emit3
 */
	.section .text.find_mngr__detect_discovery_bcon,"ax",@progbits
	.global find_mngr__detect_discovery_bcon
find_mngr__detect_discovery_bcon:
	.global L_8c6d68
L_8c6d68:
	push_s blink
L_8c6d6a:
	bl L_8c02b8
L_8c6d6e:
	mov_s r13,r0
L_8c6d70:
	ld_s r15,[r1,0x8]
L_8c6d72:
	mov_s r14,r1
L_8c6d74:
	ld_s r0,[r1,0xc]
L_8c6d76:
	/* add_s r15,0x4 */
	.byte 0x04,0xe7
L_8c6d78:
	ld r0,[r0, 0xc0]
L_8c6d7c:
	add r16,r13,0x1c
L_8c6d80:
	ldb_s r0,[r0]
L_8c6d82:
	mov_s r1,r15
L_8c6d84:
	lsr r17,r0
L_8c6d88:
	mov_s r0,r16
L_8c6d8a:
	bl.d L_8eb8dc
L_8c6d8e:
	ld_s r2,[r13,0x14]
L_8c6d90:
	breq_s r0,0,L_8c6dc2
L_8c6d92:
	ldw r4,[r15, 0x4]
L_8c6d96:
	mov_s r2,0x1013ec8
L_8c6d9c:
	ld_s r3,[r15]
L_8c6d9e:
	mov_s r0,0x9
L_8c6da0:
	mov_s r1,0x2
L_8c6da2:
	bl.d L_8ee034
L_8c6da6:
	bmsk r5,r17,0x0
L_8c6daa:
	ld_s r3,[r13,0x14]
L_8c6dac:
	mov_s r0,r16
L_8c6dae:
	mov_s r1,0x3
L_8c6db0:
	mov_s r2,r14
L_8c6db2:
	bl.d L_8d6a1c
L_8c6db6:
	mov r4,0x0
L_8c6dba:
	ld_s r0,[r13,0x14]
L_8c6dbc:
	cmp_s r0,0x2
L_8c6dbe:
	mov_s r0,0x1
L_8c6dc0:
	beq_s L_8c6dc4
	.global L_8c6dc2
L_8c6dc2:
	mov_s r0,0x0
	.global L_8c6dc4
L_8c6dc4:
	b L_8c031c
