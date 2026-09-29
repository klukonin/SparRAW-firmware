/* hwd_pcie__rgf_882b80 @ 0x8d1294, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__send_traffic_resume_evt, pcie_device_power_if__pcie_power_pcie_interrupt, pcie_device_power_if__pcie_power_wake_signal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__rgf_882b80
hwd_pcie__rgf_882b80:
	.global L_8d1294
L_8d1294:
	mov_s r1,0x882b80
L_8d129a:
	cmp_s r0,0x0
L_8d129c:
	ld_s r0,[r1,0x70]
L_8d129e:
	bset.ne r0,r0,0x5
L_8d12a2:
	bclr.eq r0,r0,0x5
L_8d12a6:
	st_s r0,[r1,0x70]
L_8d12a8:
	j_s [blink]
L_8d12aa:
	nop_s
