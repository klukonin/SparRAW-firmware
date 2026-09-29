/* l2mgr__send_pbss_joined_evt @ 0x8eea68, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_PBSS_JOINED_EVENTID for Direct Connection AID %d. fake key installation
 * Зовут его: l2mgr__publish_assoc_done
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, memcpy_fw, memset0_words, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_pbss_joined_evt,"ax",@progbits
	.global l2mgr__send_pbss_joined_evt
l2mgr__send_pbss_joined_evt:
	.global L_8eea68
L_8eea68:
	push_s blink
L_8eea6a:
	bl L_8c02c0
L_8eea6e:
	mov_s r13,r0
L_8eea70:
	bl.d L_8c2b68
L_8eea74:
	ld_s r15,[r0,0xc]
L_8eea76:
	mov_s r14,r0
L_8eea78:
	bl.d L_8c1a78
L_8eea7c:
	mov_s r1,0xc
L_8eea7e:
	add r1,r13,0x10
L_8eea82:
	add_s r0,r14,0x2
L_8eea84:
	bl.d L_8c0460
L_8eea88:
	mov_s r2,0x6
L_8eea8a:
	ld_s r0,[r15,0x14]
L_8eea8c:
	mov_s r2,0x100c4b8
L_8eea92:
	stb_s r0,[r14,0x8]
L_8eea94:
	ldb_s r0,[r13,0x8]
L_8eea96:
	mov_s r1,0x2
L_8eea98:
	stb_s r0,[r14,0x9]
L_8eea9a:
	ldb r0,[r15, 0x94]
L_8eea9e:
	stb_s r0,[r14]
L_8eeaa0:
	mov_s r0,0xb
L_8eeaa2:
	bl.d L_8edfcc
L_8eeaa6:
	ldb_s r3,[r13,0x9]
L_8eeaa8:
	mov_s r0,r14
L_8eeaaa:
	mov_s r1,0x15
L_8eeaac:
	mov_s r2,0xc
L_8eeaae:
	ldb_s r3,[r15,0x10]
L_8eeab0:
	mov r4,0x0
L_8eeab4:
	bl.d L_8e0874
L_8eeab8:
	mov r5,r4
L_8eeabc:
	b L_8c032c
