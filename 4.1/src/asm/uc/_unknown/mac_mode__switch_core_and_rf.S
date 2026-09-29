/* mac_mode__switch_core_and_rf @ 0x92a9f4, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__identify_peer, txss__init_sweep, txss__prepare_frames, txss_rx_step
 * Зовёт сам: __ld_r13_ret_uc, hw_modes_mac__switch_core, mac__program_rf_mode
 */
	.section .text.mac_mode__switch_core_and_rf,"ax",@progbits
	.global mac_mode__switch_core_and_rf
mac_mode__switch_core_and_rf:
	.global L_92a9f4
L_92a9f4:
	push_s blink
L_92a9f6:
	push_s r13
L_92a9f8:
	bl.d L_927944
L_92a9fc:
	mov_s r13,r0
L_92a9fe:
	bl.d L_9296c8
L_92aa02:
	mov_s r0,0x0
L_92aa04:
	mov_s r0,0x1f006000
L_92aa0a:
	mov_s r32,r0
L_92aa0c:
	st.ab r0,[r25,0x4]
L_92aa10:
	bclr r25,r25,0xa
L_92aa14:
	mov_s r0,0x38000300
L_92aa1a:
	mov_s r32,r0
L_92aa1c:
	st.ab r0,[r25,0x4]
L_92aa20:
	bclr r25,r25,0xa
L_92aa24:
	mov_s r0,0x3600003f
L_92aa2a:
	mov_s r32,r0
L_92aa2c:
	st.ab r0,[r25,0x4]
L_92aa30:
	bclr r25,r25,0xa
L_92aa34:
	mov_s r0,0x6000101
L_92aa3a:
	mov_s r32,r0
L_92aa3c:
	st.ab r0,[r25,0x4]
L_92aa40:
	bclr r25,r25,0xa
L_92aa44:
	mov_s r0,0x37000005
L_92aa4a:
	mov_s r32,r0
L_92aa4c:
	st.ab r0,[r25,0x4]
L_92aa50:
	bclr r25,r25,0xa
L_92aa54:
	mov_s r0,0x37000002
L_92aa5a:
	mov_s r32,r0
L_92aa5c:
	st.ab r0,[r25,0x4]
L_92aa60:
	bclr r25,r25,0xa
L_92aa64:
	or r13,r13,0x3f000000
L_92aa6c:
	mov_s r32,r13
L_92aa6e:
	st.ab r13,[r25,0x4]
L_92aa72:
	bclr r25,r25,0xa
L_92aa76:
	b L_92028c
L_92aa7a:
	nop_s
