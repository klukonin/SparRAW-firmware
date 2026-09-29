/* hwd_pcie_l1_pm_sub_ctl_get @ 0x8ce958, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_pcie_l1_pm_sub_ctl_get:: EP under SWITCH Not supported!!!
 * Зовут его: pcie__l1_dwell_stats, pcie__pm_host_config
 * Зовёт сам: fw_log__emit0, get_reg8825bc_bit3_inv, pcie_serdes_step
 */
	.section .text.hwd_pcie_l1_pm_sub_ctl_get,"ax",@progbits
	.global hwd_pcie_l1_pm_sub_ctl_get
hwd_pcie_l1_pm_sub_ctl_get:
	.global L_8ce958
L_8ce958:
	push_s blink
L_8ce95a:
	bl.d L_8ce774
L_8ce95e:
	mov_s r6,r0
L_8ce960:
	breq_s r0,0,L_8ce978
L_8ce962:
	mov r0,0x158
L_8ce966:
	mov_s r1,0x0
L_8ce968:
	mov_s r2,0x1
L_8ce96a:
	mov_s r3,r1
L_8ce96c:
	mov_s r4,r1
L_8ce96e:
	bl.d L_8eaa64
L_8ce972:
	mov r5,0x1
L_8ce976:
	b_s L_8ce986
	.global L_8ce978
L_8ce978:
	mov_s r2,0x1018c60
L_8ce97e:
	mov_s r0,0x1
L_8ce980:
	bl.d L_8edfb0
L_8ce984:
	mov_s r1,0x0
	.global L_8ce986
L_8ce986:
	pop_s blink
L_8ce988:
	j_s [blink]
L_8ce98a:
	nop_s
