/* lmac_if__lmac_ready_evt @ 0x8ede5c, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   LMAC READY :: driver_is_up_sts %x
 *   lmac_if.cpp
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r13_ret, fw_log__emit1, get_reg88265c_s1_w32, get_reg_880a3c_8d7540, l2mgr__on_lmac_ready, led_scheme__apply, lmac_if__send_abft_resp_ctrl, lmac_if__send_fw_ready_evt, lmac_if__send_phy_ina_det_cfg, lmac_if_send_cmd_0x04, lmac_if_send_cmd_0x0c, lmac_if_send_cmd_0x16
 * Глобалы (через gp): 0x8002c4, 0x8003a8
 */
	.section .text.lmac_if__lmac_ready_evt,"ax",@progbits
	.global lmac_if__lmac_ready_evt
lmac_if__lmac_ready_evt:
	.global L_8ede5c
L_8ede5c:
	push_s blink
L_8ede5e:
	push_s r13
L_8ede60:
	mov_s r0,0x1
L_8ede62:
	st.as r0,[gp,0x8e]
L_8ede66:
	bl.d L_8d8da4
L_8ede6a:
	mov_s r0,0x0
L_8ede6c:
	bl L_8d87b8
L_8ede70:
	mov_s r13,0x803e84
L_8ede76:
	ldb_s r0,[r13]
L_8ede78:
	breq r0,0xa,L_8edf02
	.global L_8ede7c
L_8ede7c:
	ldb_s r0,[r13]
L_8ede7e:
	mov_s r1,0x0
L_8ede80:
	bl.d L_8d8800
L_8ede84:
	mov_s r2,r1
L_8ede86:
	mov_s r0,0x800af8
L_8ede8c:
	bl L_8d8824
L_8ede90:
	bl L_8ce6c8
L_8ede94:
	mov_s r2,0x1003ed4
L_8ede9a:
	mov_s r3,r0
L_8ede9c:
	mov_s r0,0x0
L_8ede9e:
	bl.d L_8edfcc
L_8edea2:
	mov_s r1,0x2
L_8edea4:
	bl L_8d7540
L_8edea8:
	cmp_s r0,0x0
L_8edeaa:
	bl.ne L_8d8bd0
L_8edeae:
	st.as 0x33333333,[gp,0x55]
L_8edeb6:
	bl L_8cb6d8
L_8edeba:
	bl L_8e2668
L_8edebe:
	bl L_8d849c
L_8edec2:
	bl.d L_8d775c
L_8edec6:
	mov_s r0,0x4
L_8edec8:
	mov_s r0,0x1
L_8edeca:
	mov_s r1,0x0
L_8edecc:
	bl.d L_8d83ec
L_8eded0:
	mov_s r2,r1
L_8eded2:
	mov_s r0,0x1
L_8eded4:
	mov_s r1,0x0
L_8eded6:
	bl.d L_8d83ec
L_8ededa:
	mov_s r2,r0
L_8ededc:
	mov_s r0,0x1
L_8edede:
	mov_s r1,0x0
L_8edee0:
	bl.d L_8d83ec
L_8edee4:
	mov_s r2,0x2
L_8edee6:
	mov_s r0,0x1
L_8edee8:
	mov_s r1,0x0
L_8edeea:
	bl.d L_8d83ec
L_8edeee:
	mov_s r2,0x3
L_8edef0:
	bl.d L_8d7efc
L_8edef4:
	mov_s r0,0x0
L_8edef6:
	mov_s r0,0x0
L_8edef8:
	bl.d L_8d9e84
L_8edefc:
	mov_s r1,0x0
L_8edefe:
	b L_8c033c
	.global L_8edf02
L_8edf02:
	mov_s r0,blink
L_8edf04:
	mov_s r2,0x1003e50
L_8edf0a:
	mov_s r1,0x48
L_8edf0c:
	bset_s r1,r1,0xc
L_8edf0e:
	bl.d L_8c8208
L_8edf12:
	mov r3,0x1dc
L_8edf16:
	b_s L_8ede7c
