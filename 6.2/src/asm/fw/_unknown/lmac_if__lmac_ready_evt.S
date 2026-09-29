/* lmac_if__lmac_ready_evt @ 0x8f61b0, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   LMAC READY :: driver_is_up_sts %x
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: fw_log_emit1, hw_sysapi_rx__alloc_and_store, hwd_rfc_read_calibrate, l2mgr__on_lmac_ready, led_scheme__apply, lmac_if__config_txss_8, lmac_if__send_cmd_0x16_calib_b4, lmac_if__send_fw_ready_evt, lmac_if__send_phy_ina_det_cfg, lmac_if__send_txop_limits, lmac_if_send_cmd_0x04, lmac_if_send_cmd_0x23
 * Глобалы (через gp): 0x8002d8, 0x8003c8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__lmac_ready_evt
lmac_if__lmac_ready_evt:
	.global L_8f61b0
L_8f61b0:
	push_s blink
L_8f61b2:
	mov_s r0,0x1
L_8f61b4:
	st.as r0,[gp,0x91]
L_8f61b8:
	bl.d L_8dc2f8
L_8f61bc:
	mov_s r0,0x0
L_8f61be:
	bl L_8dbaa0
L_8f61c2:
	mov_s r1,0x8042c8
L_8f61c8:
	ldb_s r0,[r1]
L_8f61ca:
	ldb r1,[r1,0x464]
L_8f61d2:
	bl L_8dbb04
L_8f61d6:
	mov_s r0,0x800bdc
L_8f61dc:
	bl L_8dbb24
L_8f61e0:
	bl L_8d13c4
L_8f61e4:
	mov_s r1,0x1003b68
L_8f61ea:
	mov_s r2,r0
L_8f61ec:
	bl.d L_8dcc10
L_8f61f0:
	mov_s r0,0x20
L_8f61f2:
	bl L_8da61c
L_8f61f6:
	cmp_s r0,0x0
L_8f61f8:
	bl.ne L_8dc120
L_8f61fc:
	st.as 0x33333333,[gp,0x55]
L_8f6204:
	bl L_8f3d80
L_8f6208:
	bl.d L_8f3f7c
L_8f620c:
	mov r0,0x3e8
L_8f6210:
	bl L_8e78b8
L_8f6214:
	bl L_8db71c
L_8f6218:
	bl.d L_8da84c
L_8f621c:
	mov_s r0,0x4
L_8f621e:
	bl.d L_8db04c
L_8f6222:
	mov_s r0,0x0
L_8f6224:
	mov_s r0,0x0
L_8f6226:
	bl.d L_8dddc0
L_8f622a:
	mov_s r1,r0
L_8f622c:
	pop_s blink
L_8f622e:
	j_s [blink]
