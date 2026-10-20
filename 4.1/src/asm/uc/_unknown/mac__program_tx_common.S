/* mac__program_tx_common @ 0x92a3c0, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw, bcon_txss_sweep_step, direct_tx_step, mac_mode_program_a, mac_mode_program_b, rx_funcs_step, txss__tx_sector_frame, txss_flow_step
 */
	.section .text.mac__program_tx_common,"ax",@progbits
	.global mac__program_tx_common
mac__program_tx_common:
	.global L_92a3c0
L_92a3c0:
	push_s r13
L_92a3c2:
	mov_s r13,blink
L_92a3c4:
	mov_s r2,0x1b001111
L_92a3ca:
	mov_s r32,r2
L_92a3cc:
	st.ab r2,[r25,0x4]
L_92a3d0:
	bclr r25,r25,0xa
L_92a3d4:
	mov_s r1,0x161f0040
L_92a3da:
	mov_s r32,r1
L_92a3dc:
	st.ab r1,[r25,0x4]
L_92a3e0:
	bclr r25,r25,0xa
L_92a3e4:
	mov_s r0,0x17000003
L_92a3ea:
	mov_s r32,r0
L_92a3ec:
	st.ab r0,[r25,0x4]
L_92a3f0:
	bclr r25,r25,0xa
L_92a3f4:
	nop_s
L_92a3f6:
	nop_s
L_92a3f8:
	nop_s
L_92a3fa:
	mov_s blink,r13
L_92a3fc:
	j.d [blink]
L_92a400:
	pop_s r13
L_92a402:
	nop_s
