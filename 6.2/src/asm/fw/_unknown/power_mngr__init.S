/* power_mngr__init @ 0x8f5138, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 * Зовёт сам: __ld_r13_to_r13_ret, hwm_power_33kHz_clk_detector, pcie_device_power_if__init, power_mngr__defaults_addr, power_mngr__load_defaults, ps_assoc_mgr__vt04, ps_nonassoc_mgr__vt04
 * Глобалы (через gp): 0x800206, 0x800308
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_mngr__init
power_mngr__init:
	.global L_8f5138
L_8f5138:
	push_s blink
L_8f513a:
	push_s r13
L_8f513c:
	mov_s r13,0x803d10
L_8f5142:
	bl.d L_8d8e98
L_8f5146:
	add r0,r13,0x20
L_8f514a:
	bl.d L_8d90d8
L_8f514e:
	mov_s r0,r13
L_8f5150:
	bl.d L_8d8d5c
L_8f5154:
	add r0,r13,0x8
L_8f5158:
	bl L_8d8d74
L_8f515c:
	add r0,r13,0x20
L_8f5160:
	st.as r0,[gp,-0x19]
L_8f5164:
	mov_s r0,0x0
L_8f5166:
	stb r0,[gp, 0xc9]
L_8f516a:
	st.as r0,[gp,-0xe]
L_8f516e:
	bl.d L_8d777c
L_8f5172:
	st.as r0,[gp,-0xf]
L_8f5176:
	mov_s r13,r0
L_8f5178:
	st.as r0,[gp,-0x2b]
L_8f517c:
	bl.d L_8cc1f4
L_8f5180:
	st.as r0,[gp,0x61]
L_8f5184:
	ld_s r0,[r0]
L_8f5186:
	btst_s r0,0x8
L_8f5188:
	cmp.ne r13,0x0
L_8f518c:
	beq_s L_8f5196
L_8f518e:
	stw.as 0x61a8,[gp,0x41]
	.global L_8f5196
L_8f5196:
	b L_8c025c
L_8f519a:
	nop_s
