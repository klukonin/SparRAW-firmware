/* hwd_pcie__rgf_882b80 @ 0x8ce560, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__send_traffic_resume_evt, pcie_device_power_if__pcie_power_pcie_interrupt, pcie_device_power_if__pcie_power_wake_signal
 */
	.section .text.hwd_pcie__rgf_882b80,"ax",@progbits
	.global hwd_pcie__rgf_882b80
hwd_pcie__rgf_882b80:
	.global L_8ce560
L_8ce560:
	mov_s r1,0x882b80
L_8ce566:
	cmp_s r0,0x0
L_8ce568:
	ld_s r0,[r1,0x70]
L_8ce56a:
	bset.ne r0,r0,0x5
L_8ce56e:
	bclr.eq r0,r0,0x5
L_8ce572:
	st_s r0,[r1,0x70]
L_8ce574:
	j_s [blink]
L_8ce576:
	nop_s
