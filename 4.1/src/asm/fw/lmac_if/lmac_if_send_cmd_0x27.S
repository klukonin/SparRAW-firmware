/* lmac_if_send_cmd_0x27 @ 0x8d8c80, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie_device_power_sm__pcie_traffic_resume_req, set_g_800241
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x27,"ax",@progbits
	.global lmac_if_send_cmd_0x27
lmac_if_send_cmd_0x27:
	.global L_8d8c80
L_8d8c80:
	push_s blink
L_8d8c82:
	bl L_8c02c4
L_8d8c86:
	mov_s r14,r0
L_8d8c88:
	bl.d L_8c2b0c
L_8d8c8c:
	mov_s r13,r1
L_8d8c8e:
	stb_s r14,[r0]
L_8d8c90:
	stb_s r13,[r0,0x1]
L_8d8c92:
	mov_s r1,0x27
L_8d8c94:
	mov_s r2,0x2
L_8d8c96:
	bl.d L_8e0694
L_8d8c9a:
	mov_s r3,0x0
L_8d8c9c:
	b L_8c0334
