/* find_mngr__detect_discovery_bcon @ 0x8c7f40, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND MNGR: Detect discovery beacon BSSID: %08x%04x discovery_mode=%d.
 * Зовут его: dmg_bcon__rx_handler
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, basic_sm__handle_event, find_main_sm__first_detection, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mngr__detect_discovery_bcon
find_mngr__detect_discovery_bcon:
	.global L_8c7f40
L_8c7f40:
	push_s blink
L_8c7f42:
	bl L_8c01d8
L_8c7f46:
	mov_s r13,r0
L_8c7f48:
	ld_s r15,[r1,0x8]
L_8c7f4a:
	mov_s r14,r1
L_8c7f4c:
	ld_s r0,[r1,0xc]
L_8c7f4e:
	/* add_s r15,0x4 */
	.byte 0x04,0xe7
L_8c7f50:
	ld r0,[r0, 0xc0]
L_8c7f54:
	add r16,r13,0x1c
L_8c7f58:
	ldb_s r0,[r0]
L_8c7f5a:
	mov_s r1,r15
L_8c7f5c:
	lsr r17,r0
L_8c7f60:
	mov_s r0,r16
L_8c7f62:
	bl.d L_8f2ee0
L_8c7f66:
	ld_s r2,[r13,0x14]
L_8c7f68:
	breq_s r0,0,L_8c7f96
L_8c7f6a:
	ld_s r2,[r15]
L_8c7f6c:
	mov_s r1,0x1017918
L_8c7f72:
	ldw_s r3,[r15,0x4]
L_8c7f74:
	mov_s r0,0x29
L_8c7f76:
	bl.d L_8dcd00
L_8c7f7a:
	bmsk r4,r17,0x0
L_8c7f7e:
	ld_s r3,[r13,0x14]
L_8c7f80:
	mov_s r0,r16
L_8c7f82:
	mov_s r1,0x3
L_8c7f84:
	mov_s r2,r14
L_8c7f86:
	bl.d L_8d9b6c
L_8c7f8a:
	mov r4,0x0
L_8c7f8e:
	ld_s r0,[r13,0x14]
L_8c7f90:
	cmp_s r0,0x2
L_8c7f92:
	mov_s r0,0x1
L_8c7f94:
	beq_s L_8c7f98
	.global L_8c7f96
L_8c7f96:
	mov_s r0,0x0
	.global L_8c7f98
L_8c7f98:
	b L_8c023c
