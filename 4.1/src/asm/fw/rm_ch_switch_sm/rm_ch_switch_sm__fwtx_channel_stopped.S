/* rm_ch_switch_sm__fwtx_channel_stopped @ 0x8c96d4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_ch_switch_sm::fwtx_channel_stopped. send ucode RX_OFF, [tsf = 0x%x]
 *   rm_ch_switch_sm.cpp
 * Зовёт сам: __ld_r13_ret, fw_log__emit1, fw_sysassert_fatal, lmac_if_send_cmd_0x03
 */
	.section .text.rm_ch_switch_sm__fwtx_channel_stopped,"ax",@progbits
	.global rm_ch_switch_sm__fwtx_channel_stopped
rm_ch_switch_sm__fwtx_channel_stopped:
L_8c96d4:
	push_s blink
L_8c96d6:
	push_s r13
L_8c96d8:
	mov_s r13,r0
L_8c96da:
	ld_s r0,[r0,0x34]
L_8c96dc:
	bbit0 r0,0x0,L_8c9708
	.global L_8c96e0
L_8c96e0:
	ld_s r0,[r13,0x38]
L_8c96e2:
	bset_s r0,r0,0x0
L_8c96e4:
	st_s r0,[r13,0x38]
L_8c96e6:
	mov_s r0,0x886e80
L_8c96ec:
	ld_s r3,[r0,0x38]
L_8c96ee:
	ld_s r0,[r13,0x28]
L_8c96f0:
	breq_s r0,0,L_8c9700
L_8c96f2:
	mov_s r2,0x1016128
L_8c96f8:
	mov_s r0,0x8
L_8c96fa:
	bl.d L_8edfcc
L_8c96fe:
	mov_s r1,0x2
	.global L_8c9700
L_8c9700:
	bl L_8d89cc
L_8c9704:
	b L_8c033c
	.global L_8c9708
L_8c9708:
	mov_s r0,blink
L_8c970a:
	mov_s r2,0x1016114
L_8c9710:
	mov_s r1,0x116c
L_8c9716:
	bl.d L_8c82c0
L_8c971a:
	mov_s r3,0x96
L_8c971c:
	b_s L_8c96e0
L_8c971e:
	nop_s
