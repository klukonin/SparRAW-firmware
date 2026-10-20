/* disc_sm__sw_data_stopped @ 0x8f18cc, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DISC SM - spurious SW Data stopped notification.
 * Зовёт сам: WBE_DRIVER__CLOSE, __ld_r13_ret, fw_log__emit0, lm_if__on_data_stopped
 */
	.section .text.disc_sm__sw_data_stopped,"ax",@progbits
	.global disc_sm__sw_data_stopped
disc_sm__sw_data_stopped:
L_8f18cc:
	add_s sp,sp,0x4
	.global fwlog_DISC_SM_spurious_SW_Data_stopped_notific
fwlog_DISC_SM_spurious_SW_Data_stopped_notific:
L_8f18ce:
	nop_s
L_8f18d0:
	push_s blink
L_8f18d2:
	push_s r13
L_8f18d4:
	mov_s r13,r0
L_8f18d6:
	ld_s r0,[r0,0x30]
L_8f18d8:
	bbit0 r0,0x1,L_8f18f6
L_8f18dc:
	bl L_8f17d8
L_8f18e0:
	ld_s r0,[r13,0x30]
L_8f18e2:
	bic r0,r0,0x6
L_8f18e6:
	bset_s r0,r0,0x2
L_8f18e8:
	st_s r0,[r13,0x30]
L_8f18ea:
	ld_s r0,[r13,0x2c]
L_8f18ec:
	ld_s r0,[r0,0x2c]
L_8f18ee:
	bl.d L_8e2f2c
L_8f18f2:
	add_s r0,r0,0x64
L_8f18f4:
	b_s L_8f1904
	.global L_8f18f6
L_8f18f6:
	mov_s r2,0x100f884
L_8f18fc:
	mov_s r0,0xb
L_8f18fe:
	bl.d L_8edfb0
L_8f1902:
	mov_s r1,0x2
	.global L_8f1904
L_8f1904:
	b L_8c033c
