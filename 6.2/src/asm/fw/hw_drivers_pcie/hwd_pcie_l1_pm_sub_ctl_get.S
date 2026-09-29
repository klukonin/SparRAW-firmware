/* hwd_pcie_l1_pm_sub_ctl_get @ 0x8d164c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_pcie_l1_pm_sub_ctl_get:: EP under SWITCH Not supported!!!
 * Зовут его: pcie__l1ss_config, pcie_pm_host_config
 * Зовёт сам: fw_log_emit0, hwd_pcie__is_ep_under_serdes, pcie__dbi_read
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie_l1_pm_sub_ctl_get
hwd_pcie_l1_pm_sub_ctl_get:
	.global L_8d164c
L_8d164c:
	push_s blink
L_8d164e:
	bl.d L_8d1470
L_8d1652:
	mov_s r6,r0
L_8d1654:
	breq_s r0,0,L_8d166c
L_8d1656:
	mov r0,0x158
L_8d165a:
	mov_s r1,0x0
L_8d165c:
	mov_s r2,0x1
L_8d165e:
	mov_s r3,r1
L_8d1660:
	mov_s r4,r1
L_8d1662:
	bl.d L_8c8208
L_8d1666:
	mov r5,0x1
L_8d166a:
	b_s L_8d1678
	.global L_8d166c
L_8d166c:
	mov_s r1,0x101de10
L_8d1672:
	bl.d L_8dcba8
L_8d1676:
	mov_s r0,0x1
	.global L_8d1678
L_8d1678:
	pop_s blink
L_8d167a:
	j_s [blink]
