/* get_reg_880a3c_8d7210 @ 0x8d7210, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, UT_HW_MODES_cmd_handler, WBE_DRIVER__pcie_boot_init, frag_8c22b0, lm_if__on_aid_assigned, lm_if__on_linkup_ready, rs_done__snapshot_stats
 */
	.section .text.get_reg_880a3c_8d7210,"ax",@progbits
	.global get_reg_880a3c_8d7210
get_reg_880a3c_8d7210:
	.global L_8d7210
L_8d7210:
	mov_s r0,0x880a3c
L_8d7216:
	ld_s r0,[r0]
L_8d7218:
	cmp_s r0,0x2
L_8d721a:
	mov_s r0,0x1
L_8d721c:
	j_s.d [blink]
L_8d721e:
	sub_s.ne r0,r0,r0
