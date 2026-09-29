/* pcie_device_power_sm__pcie_traffic_resume_req_8e075c @ 0x8e075c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcie_device_power_sm::pcie_traffic_resume_req
 * Зовёт сам: fw_log_emit0, lmac_if_send_cmd_0x27
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_device_power_sm__pcie_traffic_resume_req_8e075c
pcie_device_power_sm__pcie_traffic_resume_req_8e075c:
	.global L_8e075c
L_8e075c:
	push_s blink
L_8e075e:
	mov_s r1,0x1002460
L_8e0764:
	bl.d L_8dcba8
L_8e0768:
	mov_s r0,0x2e
L_8e076a:
	mov_s r0,0x0
L_8e076c:
	bl.d L_8dc1f8
L_8e0770:
	mov_s r1,r0
L_8e0772:
	pop_s blink
L_8e0774:
	j_s [blink]
L_8e0776:
	nop_s
