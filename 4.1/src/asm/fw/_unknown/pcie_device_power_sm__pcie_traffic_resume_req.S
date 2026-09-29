/* pcie_device_power_sm__pcie_traffic_resume_req @ 0x8dc524, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcie_device_power_sm::pcie_traffic_resume_req
 * Зовёт сам: fw_log__emit0, lmac_if_send_cmd_0x27
 */
	.section .text.pcie_device_power_sm__pcie_traffic_resume_req,"ax",@progbits
	.global pcie_device_power_sm__pcie_traffic_resume_req
pcie_device_power_sm__pcie_traffic_resume_req:
	.byte 0xcf
	.byte 0xf1
	.global fwlog_pcie_device_power_sm_pcie_traffic_resume
fwlog_pcie_device_power_sm_pcie_traffic_resume:
L_8dc526:
	nop_s
L_8dc528:
	push_s blink
L_8dc52a:
	mov_s r2,0x100276c
L_8dc530:
	mov_s r0,0xe
L_8dc532:
	bl.d L_8edfb0
L_8dc536:
	mov_s r1,0x2
L_8dc538:
	mov_s r0,0x0
L_8dc53a:
	bl.d L_8d8c80
L_8dc53e:
	mov_s r1,r0
L_8dc540:
	pop_s blink
L_8dc542:
	j_s [blink]
