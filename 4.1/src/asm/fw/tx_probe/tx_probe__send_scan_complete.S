/* tx_probe__send_scan_complete @ 0x8f0980, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_SCAN_COMPLETE_EVENTID status %d, devid %d
 * Зовут его: low_sme__wmi_scan_cmd_handler, scan_mngr__scan_done, wmi_handler_abort_scan
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit2, get_g_8000ac_8c5c9c, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.tx_probe__send_scan_complete,"ax",@progbits
	.global tx_probe__send_scan_complete
tx_probe__send_scan_complete:
	.global L_8f0980
L_8f0980:
	push_s blink
L_8f0982:
	bl L_8c02c0
L_8f0986:
	mov_s r14,r0
L_8f0988:
	bl.d L_8c2b68
L_8f098c:
	mov_s r15,r1
L_8f098e:
	mov_s r13,r0
L_8f0990:
	st_s r14,[r0]
L_8f0992:
	mov_s r2,0x100d408
L_8f0998:
	mov_s r0,0xb
L_8f099a:
	mov_s r1,0x2
L_8f099c:
	mov_s r3,r14
L_8f099e:
	bl.d L_8edff8
L_8f09a2:
	mov_s r4,r15
L_8f09a4:
	mov_s r0,r13
L_8f09a6:
	mov_s r1,0xa
L_8f09a8:
	bset_s r1,r1,0xc
L_8f09aa:
	mov_s r2,0x4
L_8f09ac:
	mov_s r3,r15
L_8f09ae:
	mov r4,0x0
L_8f09b2:
	bl.d L_8e0874
L_8f09b6:
	mov r5,r4
L_8f09ba:
	bl.d L_8c5c9c
L_8f09be:
	mov_s r0,0x0
L_8f09c0:
	b L_8c032c
