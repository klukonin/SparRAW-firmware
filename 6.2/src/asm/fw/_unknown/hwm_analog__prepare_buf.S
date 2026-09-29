/* hwm_analog__prepare_buf @ 0x8e2960, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RESET RF!!!
 * Зовут его: hwm_analog_channel_switch, silent_rssi__set_rf_gain_index, update_rf_xx_gains_tables
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw2uc__signal_halt_and_wait_ack, fw2uc__signal_wake_and_wait_ack, fw_log_emit0, memset0_words, power_halt_seq, rf__restore_if_needed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm_analog__prepare_buf
hwm_analog__prepare_buf:
	.global L_8e2960
L_8e2960:
	push_s blink
L_8e2962:
	bl.d L_8c01e4
L_8e2966:
	mov_s r1,0x10
L_8e2968:
	sub_s sp,sp,0x10
L_8e296a:
	mov_s r13,r0
L_8e296c:
	bl.d L_8c1cd8
L_8e2970:
	mov_s r0,sp
L_8e2972:
	ld_s r0,[sp,0x0]
L_8e2974:
	mov_s r1,0x1001e54
L_8e297a:
	or r0,r0,0x1c
L_8e297e:
	st_s r0,[sp,0x0]
L_8e2980:
	bl.d L_8dcba8
L_8e2984:
	mov_s r0,0x1e
L_8e2986:
	bl.d L_8db148
L_8e298a:
	mov_s r14,sp
L_8e298c:
	mov_s r0,0x1
L_8e298e:
	mov_s r1,r14
L_8e2990:
	mov_s r2,0x0
L_8e2992:
	mov_s r3,r2
L_8e2994:
	bl.d L_8d78cc
L_8e2998:
	mov_s r4,r2
L_8e299a:
	mov_s r0,0x0
L_8e299c:
	mov_s r1,r14
L_8e299e:
	mov_s r2,0x0
L_8e29a0:
	mov_s r3,r2
L_8e29a2:
	bl.d L_8d78cc
L_8e29a6:
	mov_s r4,r2
L_8e29a8:
	cmp_s r13,0x0
L_8e29aa:
	bl.ne L_8e2acc
L_8e29ae:
	bl L_8db0d0
L_8e29b2:
	b.d L_8c0254
L_8e29b6:
	add_s sp,sp,0x10
