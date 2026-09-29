/* mgmt_tx__copy_ie_max96 @ 0x8e2048, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WBE_DRIVER::ACTIVATING PXE
 *   channels_switch_sm::radio_allocated_cb()
 * Зовут его: mgmt_tx__append_probe_resp_ies, mgmt_tx__probe_resp_ies
 * Зовёт сам: WBE_DRIVER__pxe_isoc_in_dir_bypass, __ld_r13_to_r13_ret, __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__handle_event, fw_log_emit0, fw_sysassert_fatal, memcpy_fw, pcie_dbg__rearm_irq_bit0, pcie_dbg__rearm_irq_bit3, pcie_dbg__rearm_irq_bit9
 * Глобалы (через gp): 0x800440, 0x800444
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__copy_ie_max96
mgmt_tx__copy_ie_max96:
	.global L_8e2048
L_8e2048:
	push_s blink
L_8e204a:
	bl L_8c01dc
L_8e204e:
	mov_s r16,r0
L_8e2050:
	mov_s r14,r1
L_8e2052:
	mov_s r13,r2
L_8e2054:
	cmp_s r2,0x60
L_8e2056:
	mov.gt r0,blink
L_8e205a:
	mov.gt r1,0x11d5
L_8e2062:
	bl.gt L_8c9b28
L_8e2066:
	mov_s r0,r16
L_8e2068:
	mov_s r1,r14
L_8e206a:
	bl.d L_8c0380
L_8e206e:
	mov_s r2,r13
L_8e2070:
	b.d L_8c0244
L_8e2074:
	mov_s r0,r13
L_8e2076:
	nop_s
L_8e2078:
	push_s blink
L_8e207a:
	mov_s r0,0x0
L_8e207c:
	st.as r0,[gp,-0x13]
L_8e2080:
	mov_s r1,0x1003a10
L_8e2086:
	bl.d L_8dcba8
L_8e208a:
	mov_s r0,0x2f
L_8e208c:
	ld_s r0,[gp,0x2c0]
L_8e208e:
	cmp_s r0,0x0
L_8e2090:
	bl.ne L_8fa874
L_8e2094:
	ld_s r0,[gp,0x2bc]
L_8e2096:
	breq_s r0,0,L_8e20a6
L_8e2098:
	bl.d L_8f7eb0
L_8e209c:
	mov_s r0,0x0
L_8e209e:
	bl L_8fa854
L_8e20a2:
	bl L_8fa864
	.global L_8e20a6
L_8e20a6:
	mov_s r1,0x882d80
L_8e20ac:
	ld_s r0,[r1,0x54]
L_8e20ae:
	bset_s r0,r0,0x1f
L_8e20b0:
	st_s r0,[r1,0x54]
L_8e20b2:
	pop_s blink
L_8e20b4:
	j_s [blink]
L_8e20b6:
	nop_s
L_8e20b8:
	push_s blink
L_8e20ba:
	push_s r13
L_8e20bc:
	mov_s r13,r1
L_8e20be:
	mov_s r1,0x10175a0
L_8e20c4:
	bl.d L_8dcba8
L_8e20c8:
	mov_s r0,0x29
L_8e20ca:
	mov_s r0,r13
L_8e20cc:
	mov_s r1,0x1
L_8e20ce:
	mov_s r2,0x0
L_8e20d0:
	mov_s r3,r2
L_8e20d2:
	bl.d L_8d9b6c
L_8e20d6:
	mov_s r4,r2
L_8e20d8:
	b L_8c025c
