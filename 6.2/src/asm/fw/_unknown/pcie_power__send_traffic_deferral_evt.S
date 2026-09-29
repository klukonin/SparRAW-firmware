/* pcie_power__send_traffic_deferral_evt @ 0x8e97b0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_traffic_deferral_cfg_evt
 * Зовёт сам: l2mgr__send_traffic_deferral_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_power__send_traffic_deferral_evt
pcie_power__send_traffic_deferral_evt:
	.global L_8e97b0
L_8e97b0:
	mov_s r1,r0
L_8e97b2:
	mov_s r0,0x803d10
L_8e97b8:
	b L_8e04f4
