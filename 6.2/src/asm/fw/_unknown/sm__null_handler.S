/* sm__null_handler @ 0x8df4f0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__call_vmethod_04, tx_api__check_state_2
 * Зовёт сам: rm_ch_switch_sm__fwtx_channel_stopped
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm__null_handler
sm__null_handler:
	.global L_8df4f0
L_8df4f0:
	mov_s r1,0x0
L_8df4f2:
	st_s r1,[r0,0x8]
L_8df4f4:
	ld_s r1,[r0]
L_8df4f6:
	ld_s r0,[r1,0x1c]
L_8df4f8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8df4fa:
	b.d L_8cb6a8
L_8df4fe:
	st_s r0,[r1,0x1c]
