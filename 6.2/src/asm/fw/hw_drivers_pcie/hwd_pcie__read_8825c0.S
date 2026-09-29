/* hwd_pcie__read_8825c0 @ 0x8d141c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__l1_latency_wa, pcie_device_power_sm__pcie_traffic_resume_req, pcie_perst_handler_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__read_8825c0
hwd_pcie__read_8825c0:
	.global L_8d141c
L_8d141c:
	mov_s r0,0x882580
L_8d1422:
	ld_s r0,[r0,0x40]
L_8d1424:
	j_s [blink]
L_8d1426:
	nop_s
