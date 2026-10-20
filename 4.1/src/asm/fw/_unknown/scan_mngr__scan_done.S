/* scan_mngr__scan_done @ 0x8f0000, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::scan_done()
 *   scan_mngr::scan_done() scan done notify host status = 0x%x <ts: %d> scan type:%d
 *   scan_mngr::scan_done() passive scan done notify host status = 0x%x <ts: %d> scan type:%d
 *   scan_mngr::scan_done() send command to uCode scan_mode = FALSE.
 * Зовут его: channels_switch_sm__action_scan_complete
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, discovery__rx_stop, fw_div_unsigned, fw_log__emit0, fw_log__emit3, fw_read_timer, l2_mgr__scan_complete_handle, l2mgr__send_scan_complete_evt, lmac_if_discovery_mode_cfg_handler, scan_mngr__clean_all_lists, tx_probe__send_scan_complete
 */
	.section .text.scan_mngr__scan_done,"ax",@progbits
	.global scan_mngr__scan_done
scan_mngr__scan_done:
	.global L_8f0000
L_8f0000:
	push_s blink
L_8f0002:
	bl L_8c02c0
L_8f0006:
	mov_s r14,r0
L_8f0008:
	mov_s r13,r1
L_8f000a:
	mov_s r2,0x1012fe0
L_8f0010:
	mov_s r0,0x9
L_8f0012:
	bl.d L_8edfb0
L_8f0016:
	mov_s r1,0x2
L_8f0018:
	cmp_s r13,0x3
L_8f001a:
	bl.ne L_8efdac
L_8f001e:
	mov_s r1,0x805d88
L_8f0024:
	ldw_s r0,[r1,0x1c]
L_8f0026:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f0028:
	extw_s r0,r0
L_8f002a:
	stw_s r0,[r1,0x1c]
L_8f002c:
	bl.d L_8ea324
L_8f0030:
	mov_s r0,r14
L_8f0032:
	ld r0,[r14, 0x80]
L_8f0036:
	cmp_s r0,0x0
L_8f0038:
	ld_s r0,[r14,0x6c]
L_8f003a:
	mov.ne r13,0x2
L_8f003e:
	cmp_s r0,0x2
L_8f0040:
	mov_s r0,0x1
L_8f0042:
	sub_s.ne r0,r0,r0
L_8f0044:
	extb.f 0x0,r0
L_8f0048:
	bne_s L_8f0070
L_8f004a:
	bl L_8e4694
L_8f004e:
	ld r5,[r14, 0x6c]
L_8f0052:
	mov_s r4,r0
L_8f0054:
	mov_s r2,0x1012ff8
L_8f005a:
	mov_s r0,0x9
L_8f005c:
	mov_s r1,0x2
L_8f005e:
	bl.d L_8ee034
L_8f0062:
	mov_s r3,r13
L_8f0064:
	ld_s r1,[r14,0x7c]
L_8f0066:
	mov_s r0,r13
L_8f0068:
	bl.d L_8f0980
L_8f006c:
	ldb_s r1,[r1,0x10]
L_8f006e:
	b_s L_8f00a8
	.global L_8f0070
L_8f0070:
	bl L_8e4694
L_8f0074:
	ld r5,[r14, 0x6c]
L_8f0078:
	mov_s r4,r0
L_8f007a:
	mov_s r2,0x101304c
L_8f0080:
	mov_s r0,0x9
L_8f0082:
	mov_s r1,0x2
L_8f0084:
	bl.d L_8ee034
L_8f0088:
	mov_s r3,r13
L_8f008a:
	ld_s r15,[r14,0x7c]
L_8f008c:
	ld_s r0,[r14,0x70]
L_8f008e:
	bl.d L_8c03b4
L_8f0092:
	mov r1,0x3e8
L_8f0096:
	mov_s r2,r0
L_8f0098:
	ldb_s r1,[r15,0x10]
L_8f009a:
	extb_s r0,r13
L_8f009c:
	add r4,r14,0x28
L_8f00a0:
	bl.d L_8f0654
L_8f00a4:
	ldb r3,[r14, 0x24]
	.global L_8f00a8
L_8f00a8:
	mov_s r13,0x0
L_8f00aa:
	st_s r13,[r14,0x78]
L_8f00ac:
	mov_s r2,0x10130a8
L_8f00b2:
	mov_s r0,0x9
L_8f00b4:
	bl.d L_8edfb0
L_8f00b8:
	mov_s r1,0x2
L_8f00ba:
	mov_s r0,r13
L_8f00bc:
	bl.d L_8d84a8
L_8f00c0:
	ldb r1,[r14, 0x8e]
L_8f00c4:
	ld_s r0,[r14,0x7c]
L_8f00c6:
	ldb_s r0,[r0,0x10]
L_8f00c8:
	bl.d L_8eff7c
L_8f00cc:
	mov_s r1,0x1
L_8f00ce:
	b L_8c032c
L_8f00d2:
	nop_s
