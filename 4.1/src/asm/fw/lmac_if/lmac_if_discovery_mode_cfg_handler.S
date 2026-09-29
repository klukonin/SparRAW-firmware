/* lmac_if_discovery_mode_cfg_handler @ 0x8d84a8, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_discovery_mode_cfg_handler() send command to uCode discovery_mode = %d. m_discovery_type = %d
 * Зовут его: find_mngr__listen_start, find_mngr__search_start, find_mngr__stop, scan_mngr__scan_done, scan_mngr__start_scan
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_if__alloc_mbox_slot, fw_log__emit2, send_cmd2_lmac
 */
	.section .text.lmac_if_discovery_mode_cfg_handler,"ax",@progbits
	.global lmac_if_discovery_mode_cfg_handler
lmac_if_discovery_mode_cfg_handler:
	.global L_8d84a8
L_8d84a8:
	push_s blink
L_8d84aa:
	bl L_8c02c0
L_8d84ae:
	mov_s r14,r0
L_8d84b0:
	mov_s r0,0x803e3c
L_8d84b6:
	bl.d L_8c2c38
L_8d84ba:
	mov_s r15,r1
L_8d84bc:
	mov.f r13,r0
L_8d84c0:
	beq_s L_8d84ea
L_8d84c2:
	mov.f r3,r14
L_8d84c6:
	mov_s r2,0x1004c90
L_8d84cc:
	mov.ne r3,0x1
L_8d84d0:
	st_s r3,[r13]
L_8d84d2:
	st_s r15,[r13,0x4]
L_8d84d4:
	mov_s r0,0x9
L_8d84d6:
	mov_s r1,0x2
L_8d84d8:
	bl.d L_8edff8
L_8d84dc:
	mov_s r4,r15
L_8d84de:
	mov_s r0,r13
L_8d84e0:
	mov_s r1,0x24
L_8d84e2:
	mov_s r2,0x8
L_8d84e4:
	bl.d L_8e0694
L_8d84e8:
	mov_s r3,0x0
	.global L_8d84ea
L_8d84ea:
	b L_8c032c
L_8d84ee:
	nop_s
