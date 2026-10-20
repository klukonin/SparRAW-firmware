/* channels_switch_sm__action_scan_complete @ 0x8e9118, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_scan_complete() ,scan_succsess %d
 *   channels_switch_sm::action_scan_complete()  unlocking radio 0x%x
 * Зовёт сам: RADIO_MGR__unlock, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, scan_mngr__scan_done, u_schd__cancel
 */
	.section .text.channels_switch_sm__action_scan_complete,"ax",@progbits
	.global channels_switch_sm__action_scan_complete
channels_switch_sm__action_scan_complete:
L_8e9118:
	push_s blink
L_8e911a:
	bl L_8c02c4
L_8e911e:
	mov_s r13,r0
L_8e9120:
	mov_s r14,r1
L_8e9122:
	mov_s r2,0x1014424
L_8e9128:
	mov_s r0,0x9
L_8e912a:
	mov_s r1,0x2
L_8e912c:
	bl.d L_8edfcc
L_8e9130:
	mov_s r3,r14
L_8e9132:
	ld_s r0,[r13,0x3c]
L_8e9134:
	breq_s r0,0,L_8e913e
L_8e9136:
	bl L_8c7794
L_8e913a:
	mov_s r0,0x0
L_8e913c:
	st_s r0,[r13,0x3c]
	.global L_8e913e
L_8e913e:
	mov_s r2,0x1014464
L_8e9144:
	mov_s r0,0xc
L_8e9146:
	mov_s r1,0x2
L_8e9148:
	bl.d L_8edfcc
L_8e914c:
	ld_s r3,[r13,0x30]
L_8e914e:
	bl.d L_8e54d8
L_8e9152:
	ld_s r0,[r13,0x30]
L_8e9154:
	cmp_s r14,0x0
L_8e9156:
	ld_s r0,[r13,0x2c]
L_8e9158:
	mov_s r1,0x0
L_8e915a:
	mov.eq r1,0x1
L_8e915e:
	bl L_8f0000
L_8e9162:
	.byte 0xd5,0x01
