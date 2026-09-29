/* hwd_pcie_config_lnkctl @ 0x8d17f8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_pcie_config_lnkctl:: EP under SWITCH Not supported!!!
 * Зовут его: pcie_pm_host_config
 * Зовёт сам: fw_log_emit0, hwd_pcie__is_ep_under_serdes, pcie__dbi_read
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie_config_lnkctl
hwd_pcie_config_lnkctl:
	.global L_8d17f8
L_8d17f8:
	push_s blink
L_8d17fa:
	bl.d L_8d1470
L_8d17fe:
	mov_s r6,r0
L_8d1800:
	breq_s r0,0,L_8d1816
L_8d1802:
	mov_s r0,0x80
L_8d1804:
	mov_s r1,0x0
L_8d1806:
	mov_s r2,0x1
L_8d1808:
	mov_s r3,r1
L_8d180a:
	mov_s r4,r1
L_8d180c:
	bl.d L_8c8208
L_8d1810:
	mov r5,0x1
L_8d1814:
	b_s L_8d1822
	.global L_8d1816
L_8d1816:
	mov_s r1,0x101de50
L_8d181c:
	bl.d L_8dcba8
L_8d1820:
	mov_s r0,0x1
	.global L_8d1822
L_8d1822:
	pop_s blink
L_8d1824:
	j_s [blink]
L_8d1826:
	nop_s
