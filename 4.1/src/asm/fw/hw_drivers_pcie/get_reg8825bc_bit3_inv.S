/* get_reg8825bc_bit3_inv @ 0x8ce774, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dbi_write_seq, hwd_pcie__get_ltssm_state, hwd_pcie__set_low_power, hwd_pcie_config_lnkctl, hwd_pcie_exit_l1, hwd_pcie_l1_pm_sub_ctl_get, hwd_pcie_l1_sub_timing_config, hwd_pcie_lnkctl_set, pcie__apply_880a80_mode, pcie__fix_max_read_req
 */
	.section .text.get_reg8825bc_bit3_inv,"ax",@progbits
	.global get_reg8825bc_bit3_inv
get_reg8825bc_bit3_inv:
	.global L_8ce774
L_8ce774:
	mov_s r0,0x882580
L_8ce77a:
	ld_s r0,[r0,0x3c]
L_8ce77c:
	lsr_s r0,r0,0x3
L_8ce77e:
	bxor r0,r0,0x0
L_8ce782:
	j_s.d [blink]
L_8ce784:
	bmsk_s r0,r0,0x0
L_8ce786:
	nop_s
