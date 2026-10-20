/* lmac_if_echo_evt_handler @ 0x8d84f0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_echo_evt_handler sending deep echo back to SW %x
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, lmac_echo__alloc_mbox_slot, lmac_echo__report_to_host
 */
	.section .text.lmac_if_echo_evt_handler,"ax",@progbits
	.global lmac_if_echo_evt_handler
lmac_if_echo_evt_handler:
	.global L_8d84f0
L_8d84f0:
	push_s blink
L_8d84f2:
	bl L_8c02c4
L_8d84f6:
	bl.d L_8c2b78
L_8d84fa:
	mov_s r14,r0
L_8d84fc:
	ld_s r3,[r14]
L_8d84fe:
	mov_s r13,r0
L_8d8500:
	st_s r3,[r0]
L_8d8502:
	mov_s r2,0x1003ef8
L_8d8508:
	mov_s r0,0x0
L_8d850a:
	bl.d L_8edfcc
L_8d850e:
	mov_s r1,0x2
L_8d8510:
	mov_s r0,r13
L_8d8512:
	mov_s r1,0x1803
L_8d8518:
	mov_s r2,0x4
L_8d851a:
	bl.d L_8e0984
L_8d851e:
	mov_s r3,0x0
L_8d8520:
	b L_8c0334
