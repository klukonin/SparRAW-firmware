/* hwd_pcie_lnkctl_set @ 0x8d1828, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_pcie_lnkctl_set:: EP under SWITCH Not supported yet!!!
 * Зовут его: pcie_pm_host_config
 * Зовёт сам: dbi_write, fw_log_emit0, hwd_pcie__is_ep_under_serdes
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie_lnkctl_set
hwd_pcie_lnkctl_set:
	.global L_8d1828
L_8d1828:
	push_s blink
L_8d182a:
	sub_s sp,sp,0x4
L_8d182c:
	bl.d L_8d1470
L_8d1830:
	mov_s r1,r0
L_8d1832:
	breq_s r0,0,L_8d1850
L_8d1834:
	mov_s r2,0x0
L_8d1836:
	st_s r2,[sp,0x0]
L_8d1838:
	mov_s r0,0x80
L_8d183a:
	ld_s r1,[r1]
L_8d183c:
	mov_s r3,0x1
L_8d183e:
	mov_s r4,r2
L_8d1840:
	mov_s r5,r2
L_8d1842:
	mov r6,0x1
L_8d1846:
	bl.d L_8c8338
L_8d184a:
	mov r7,0x1
L_8d184e:
	b_s L_8d185c
	.global L_8d1850
L_8d1850:
	mov_s r1,0x101de8c
L_8d1856:
	bl.d L_8dcba8
L_8d185a:
	mov_s r0,0x1
	.global L_8d185c
L_8d185c:
	add_s sp,sp,0x4
L_8d185e:
	pop_s blink
L_8d1860:
	j_s [blink]
L_8d1862:
	nop_s
