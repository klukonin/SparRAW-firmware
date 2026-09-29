/* hwd_pcie_ltssm_is_l1_idle @ 0x8ce32c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter, hwd_pcie_l1_enter_isr, hwd_pcie_l1_exit_isr, link_lost_diag__dump_pcie, pcie__l1_idle_and_park
 */
	.section .text.hwd_pcie_ltssm_is_l1_idle,"ax",@progbits
	.global hwd_pcie_ltssm_is_l1_idle
hwd_pcie_ltssm_is_l1_idle:
	.global L_8ce32c
L_8ce32c:
	mov_s r0,0x88b080
L_8ce332:
	ld_s r0,[r0,0x50]
L_8ce334:
	and r0,r0,0x800000
L_8ce33c:
	cmp_s r0,0x0
L_8ce33e:
	mov_s r0,0x1
L_8ce340:
	j_s.d [blink]
L_8ce342:
	sub_s.ne r0,r0,r0
