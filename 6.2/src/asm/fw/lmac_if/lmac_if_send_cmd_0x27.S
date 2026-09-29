/* lmac_if_send_cmd_0x27 @ 0x8dc1f8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie_device_power_sm__pcie_traffic_resume_req_8e075c, power_mngr__set_traffic_deferral
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_send_cmd_0x27
lmac_if_send_cmd_0x27:
	.global L_8dc1f8
L_8dc1f8:
	push_s blink
L_8dc1fa:
	bl L_8c01e4
L_8dc1fe:
	mov_s r14,r0
L_8dc200:
	bl.d L_8c3284
L_8dc204:
	mov_s r13,r1
L_8dc206:
	stb_s r14,[r0]
L_8dc208:
	stb_s r13,[r0,0x1]
L_8dc20a:
	mov_s r1,0x27
L_8dc20c:
	mov_s r2,0x2
L_8dc20e:
	bl.d L_8e5204
L_8dc212:
	mov_s r3,0x0
L_8dc214:
	b L_8c0254
