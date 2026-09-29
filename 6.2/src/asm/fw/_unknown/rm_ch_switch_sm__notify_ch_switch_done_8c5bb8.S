/* rm_ch_switch_sm__notify_ch_switch_done_8c5bb8 @ 0x8c5bb8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_ch_switch_sm::notify_ch_switch_done [channel = %d]
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_ch_switch_sm__notify_ch_switch_done_8c5bb8
rm_ch_switch_sm__notify_ch_switch_done_8c5bb8:
	.global L_8c5bb8
L_8c5bb8:
	push_s blink
L_8c5bba:
	push_s r13
L_8c5bbc:
	mov_s r13,r0
L_8c5bbe:
	ldb_s r0,[r0,0x3]
L_8c5bc0:
	ld_s r2,[r13,0x18]
L_8c5bc2:
	breq_s r0,0,L_8c5bd0
L_8c5bc4:
	mov_s r1,0x1019558
L_8c5bca:
	bl.d L_8dcc10
L_8c5bce:
	mov_s r0,0x28
	.global L_8c5bd0
L_8c5bd0:
	ld_s r3,[r13,0xc]
L_8c5bd2:
	ld_s r0,[r13,0x8]
L_8c5bd4:
	mov_s r1,0x2
L_8c5bd6:
	ldb r4,[r3, 0x24]
L_8c5bda:
	ld_s r2,[r13,0x18]
L_8c5bdc:
	bl.d L_8d9b6c
L_8c5be0:
	ld_s r3,[r3,0x4]
L_8c5be2:
	b L_8c025c
L_8c5be6:
	nop_s
