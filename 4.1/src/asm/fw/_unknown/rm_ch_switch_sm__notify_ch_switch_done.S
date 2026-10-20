/* rm_ch_switch_sm__notify_ch_switch_done @ 0x8c4db0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_ch_switch_sm::notify_ch_switch_done [channel = %d]
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit1
 */
	.section .text.rm_ch_switch_sm__notify_ch_switch_done,"ax",@progbits
	.global rm_ch_switch_sm__notify_ch_switch_done
rm_ch_switch_sm__notify_ch_switch_done:
L_8c4db0:
	push_s blink
L_8c4db2:
	push_s r13
L_8c4db4:
	mov_s r13,r0
L_8c4db6:
	ld_s r0,[r0,0x28]
L_8c4db8:
	ld_s r3,[r13,0x3c]
L_8c4dba:
	breq_s r0,0,L_8c4dca
L_8c4dbc:
	mov_s r2,0x101620c
L_8c4dc2:
	mov_s r0,0x8
L_8c4dc4:
	bl.d L_8edfcc
L_8c4dc8:
	mov_s r1,0x2
	.global L_8c4dca
L_8c4dca:
	ld_s r3,[r13,0x30]
L_8c4dcc:
	ld_s r0,[r13,0x2c]
L_8c4dce:
	mov_s r1,0x2
L_8c4dd0:
	ldb r4,[r3, 0x24]
L_8c4dd4:
	ld_s r2,[r13,0x3c]
L_8c4dd6:
	bl.d L_8d6a1c
L_8c4dda:
	ld_s r3,[r3,0x4]
L_8c4ddc:
	b L_8c033c
