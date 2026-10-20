/* hw_sysapi__set_freq_ratio @ 0x8ce484, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_sysapi_set_freq_ratio is asking for radio
 *   radio request handle is 0x%X
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, channel__check_range, fw_log_emit0, fw_log_emit1, radio__get_channel, radio_mgr__request
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_sysapi__set_freq_ratio
hw_sysapi__set_freq_ratio:
	.global L_8ce484
L_8ce484:
	push_s blink
L_8ce486:
	bl L_8c01e0
L_8ce48a:
	mov_s r13,r0
L_8ce48c:
	mov_s r14,r1
L_8ce48e:
	mov_s r0,0x8042c8
L_8ce494:
	bl.d L_8cc13c
L_8ce498:
	mov_s r15,r2
L_8ce49a:
	breq r13,r0,L_8ce4aa
L_8ce49e:
	mov_s r0,r13
L_8ce4a0:
	mov_s r1,r14
L_8ce4a2:
	bl.d L_8cfadc
L_8ce4a6:
	mov_s r2,r15
L_8ce4a8:
	b_s L_8ce4e4
	.global L_8ce4aa
L_8ce4aa:
	mov_s r1,0x101a5a8
L_8ce4b0:
	bl.d L_8dcba8
L_8ce4b4:
	mov_s r0,0x25
L_8ce4b6:
	mov_s r1,0x806690
L_8ce4bc:
	st_s r13,[r1]
L_8ce4be:
	st_s r14,[r1,0x4]
L_8ce4c0:
	st_s r15,[r1,0x8]
L_8ce4c2:
	mov_s r0,0xe458
L_8ce4c8:
	mov_s r2,0x0
L_8ce4ca:
	mov_s r3,0xffff
L_8ce4d0:
	bl.d L_8dcaf4
L_8ce4d4:
	mov_s r4,r2
L_8ce4d6:
	mov_s r2,r0
L_8ce4d8:
	mov_s r1,0x101a5d8
L_8ce4de:
	bl.d L_8dcc10
L_8ce4e2:
	mov_s r0,0x25
	.global L_8ce4e4
L_8ce4e4:
	b L_8c024c
