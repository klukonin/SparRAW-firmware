/* channels_switch_sm__action_abort_dwelling @ 0x8e8f00, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_abort_dwelling() while dwelling!!!
 * Зовут его: scan_mngr__prob_done, scan_mngr__stop_dwelling
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0, u_schd__cancel
 */
	.section .text.channels_switch_sm__action_abort_dwelling,"ax",@progbits
	.global channels_switch_sm__action_abort_dwelling
channels_switch_sm__action_abort_dwelling:
	.global L_8e8f00
L_8e8f00:
	push_s blink
L_8e8f02:
	push_s r13
L_8e8f04:
	mov_s r13,r0
L_8e8f06:
	mov_s r2,0x101452c
L_8e8f0c:
	mov_s r0,0x9
L_8e8f0e:
	bl.d L_8edfb0
L_8e8f12:
	mov_s r1,0x2
L_8e8f14:
	ld_s r0,[r13,0x38]
L_8e8f16:
	cmp_s r0,0x0
L_8e8f18:
	bl.ne L_8c7794
L_8e8f1c:
	mov_s r0,r13
L_8e8f1e:
	mov_s r1,0x4
L_8e8f20:
	mov_s r2,0x0
L_8e8f22:
	mov_s r3,r2
L_8e8f24:
	bl.d L_8d6a1c
L_8e8f28:
	mov_s r4,r2
L_8e8f2a:
	.byte 0x15,0x04
