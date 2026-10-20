/* hwd_pcie__is_ep_under_serdes @ 0x8d1470, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_pcie__get_ltssm_state, hwd_pcie__set_low_power, hwd_pcie_config_lnkctl, hwd_pcie_exit_l1, hwd_pcie_l1_pm_sub_ctl_get, hwd_pcie_l1_sub_timing_config, hwd_pcie_lnkctl_set, pcie__apply_mode_fw_8825c0__8d10c8, pcie__fix_max_read_req, pcie__force_clear_l0s
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__is_ep_under_serdes
hwd_pcie__is_ep_under_serdes:
	.global L_8d1470
L_8d1470:
	mov_s r0,0x882580
L_8d1476:
	ld_s r0,[r0,0x3c]
L_8d1478:
	lsr_s r0,r0,0x3
L_8d147a:
	bxor r0,r0,0x0
L_8d147e:
	j_s.d [blink]
L_8d1480:
	bmsk_s r0,r0,0x0
L_8d1482:
	nop_s
