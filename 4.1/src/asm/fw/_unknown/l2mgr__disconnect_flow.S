/* l2mgr__disconnect_flow @ 0x8eb11c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    DISCONNECT flow started m_graceful = %d.
 * Зовёт сам: STREAM_MGR, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1
 */
	.section .text.l2mgr__disconnect_flow,"ax",@progbits
	.global l2mgr__disconnect_flow
l2mgr__disconnect_flow:
L_8eb11c:
	push_s blink
L_8eb11e:
	bl.d L_8c02c4
L_8eb122:
	mov_s r3,0x0
L_8eb124:
	mov_s r14,r0
L_8eb126:
	add r13,r0,0x20
L_8eb12a:
	stb_s r1,[r13,0x18]
L_8eb12c:
	stw_s r2,[r0,0x3a]
L_8eb12e:
	ld_s r0,[r0,0x30]
L_8eb130:
	mov_s r2,0x1
L_8eb132:
	bset_s r0,r0,0x1
L_8eb134:
	st_s r0,[r14,0x30]
L_8eb136:
	st_s r3,[r14,0x34]
L_8eb138:
	cmp_s r1,0x2
L_8eb13a:
	cmp.ne r1,0x7
L_8eb13e:
	cmp.ne r1,0x1
L_8eb142:
	bne_s L_8eb148
L_8eb144:
	st_s r2,[r14,0x34]
L_8eb146:
	mov_s r3,0x1
	.global L_8eb148
L_8eb148:
	mov_s r2,0x100f96c
L_8eb14e:
	mov_s r0,0xb
L_8eb150:
	bl.d L_8edfcc
L_8eb154:
	mov_s r1,0x2
L_8eb156:
	ld_s r0,[r14,0x2c]
L_8eb158:
	ld_s r1,[r14,0x34]
L_8eb15a:
	ld_s r0,[r0,0x2c]
L_8eb15c:
	bl.d L_8de468
L_8eb160:
	ldb_s r2,[r13,0x18]
L_8eb162:
	.byte 0xd5,0x01
