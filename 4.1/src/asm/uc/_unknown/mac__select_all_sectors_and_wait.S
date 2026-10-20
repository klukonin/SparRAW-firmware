/* mac__select_all_sectors_and_wait @ 0x931980, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_txss_sweep_step, bi_manager__rx_flow_body, internal_tx_step, tx_initiator_flow, tx_mtp__open_window, tx_rate_select_and_program, txop__open_window
 * Зовёт сам: uc_wait_event_busy
 */
	.section .text.mac__select_all_sectors_and_wait,"ax",@progbits
	.global mac__select_all_sectors_and_wait
mac__select_all_sectors_and_wait:
	.global L_931980
L_931980:
	ld.as r1,[gp,-0x12]
L_931984:
	or r1,r1,0x27007e00
L_93198c:
	mov r32,r1
L_931990:
	st.ab r1,[r25,0x4]
L_931994:
	bclr r25,r25,0xa
L_931998:
	mov_s r0,0x2004002
L_93199e:
	mov_s r32,r0
L_9319a0:
	st.ab r0,[r25,0x4]
L_9319a4:
	bclr r25,r25,0xa
L_9319a8:
	nop_s
L_9319aa:
	nop_s
L_9319ac:
	nop_s
L_9319ae:
	mov_s r0,0x2
L_9319b0:
	bset r0,r0,0xe
L_9319b4:
	b.d L_931808
L_9319b8:
	mov_s r1,0x0
L_9319ba:
	nop_s
