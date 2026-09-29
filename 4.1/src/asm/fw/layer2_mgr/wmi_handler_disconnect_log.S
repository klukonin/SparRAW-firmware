/* wmi_handler_disconnect_log @ 0x8eb1d4, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WMI Disconnect MID:[%d] reason = %d  protocol %d
 *   layer2_mgr.cpp
 * Зовут его: wmi_handler_disconnect
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit3, fw_sysassert_fatal, get_g_8000ac_8e15e0, mid_list__by_mid, mid_list__disconnect_all
 */
	.section .text.wmi_handler_disconnect_log,"ax",@progbits
	.global wmi_handler_disconnect_log
wmi_handler_disconnect_log:
	.global L_8eb1d4
L_8eb1d4:
	push_s blink
L_8eb1d6:
	bl L_8c02b4
L_8eb1da:
	mov_s r18,r0
L_8eb1dc:
	mov_s r17,r1
L_8eb1de:
	bl.d L_8ca1b0
L_8eb1e2:
	mov_s r16,r2
L_8eb1e4:
	mov.f r13,r0
L_8eb1e8:
	beq_s L_8eb216
	.global L_8eb1ea
L_8eb1ea:
	bl.d L_8e15e0
L_8eb1ee:
	mov_s r0,0x2
L_8eb1f0:
	mov_s r2,0x100c6f0
L_8eb1f6:
	mov_s r0,0xb
L_8eb1f8:
	mov_s r1,0x2
L_8eb1fa:
	mov_s r3,r18
L_8eb1fc:
	mov r4,r17
L_8eb200:
	bl.d L_8ee034
L_8eb204:
	mov r5,r16
L_8eb208:
	mov_s r0,r13
L_8eb20a:
	mov_s r1,r17
L_8eb20c:
	bl.d L_8c7a60
L_8eb210:
	mov_s r2,r16
L_8eb212:
	b L_8c0314
	.global L_8eb216
L_8eb216:
	mov_s r0,blink
L_8eb218:
	mov_s r2,0x100c474
L_8eb21e:
	mov_s r1,0x8f
L_8eb220:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8eb222:
	bl.d L_8c82c0
L_8eb226:
	mov r3,0x531
L_8eb22a:
	b_s L_8eb1ea
