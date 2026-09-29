/* hw__is_fpga_platform @ 0x8da2c8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, UT_HW_FLOWS_OPERATIONAL_cmd_handler, UT_HW_MODES_cmd_handler, conn__snapshot_step, conn_main_sm__action_step_b, fw_main, lm_if__on_linkup_ready, lmac_if__rs_done_params
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw__is_fpga_platform
hw__is_fpga_platform:
	.global L_8da2c8
L_8da2c8:
	mov_s r0,0x880a3c
L_8da2ce:
	ld_s r0,[r0]
L_8da2d0:
	cmp_s r0,0x2
L_8da2d2:
	mov_s r0,0x1
L_8da2d4:
	j_s.d [blink]
L_8da2d6:
	sub_s.ne r0,r0,r0
