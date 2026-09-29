/* ps_traffic_deferral_cfg_evt @ 0x8dc218, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: pcie_power__send_traffic_deferral_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_traffic_deferral_cfg_evt
ps_traffic_deferral_cfg_evt:
	.global L_8dc218
L_8dc218:
	ld_s r0,[r0,0x4]
L_8dc21a:
	cmp_s r0,0x0
L_8dc21c:
	mov_s r0,0x1
L_8dc21e:
	b.d L_8e97b0
L_8dc222:
	sub_s.ne r0,r0,r0
