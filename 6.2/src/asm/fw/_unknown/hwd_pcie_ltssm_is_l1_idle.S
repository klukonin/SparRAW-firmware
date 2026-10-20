/* hwd_pcie_ltssm_is_l1_idle @ 0x8d1070, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter, fw_vector_18__pair, hwd_pcie_l1_enter_isr, link_lost_diag__dump_pcie, pcie__l1_idle_and_park
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie_ltssm_is_l1_idle
hwd_pcie_ltssm_is_l1_idle:
	.global L_8d1070
L_8d1070:
	mov_s r0,0x88b080
L_8d1076:
	ld_s r0,[r0,0x50]
L_8d1078:
	and r0,r0,0x800000
L_8d1080:
	cmp_s r0,0x0
L_8d1082:
	mov_s r0,0x1
L_8d1084:
	j_s.d [blink]
L_8d1086:
	sub_s.ne r0,r0,r0
