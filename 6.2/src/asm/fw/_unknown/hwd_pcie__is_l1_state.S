/* hwd_pcie__is_l1_state @ 0x8d1054, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_pcie_exit_l1, pcie__l1ss_config, pcie_pm_host_config
 * Зовёт сам: hwd_pcie__get_ltssm_state
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__is_l1_state
hwd_pcie__is_l1_state:
	.global L_8d1054
L_8d1054:
	push_s blink
L_8d1056:
	bl L_8d13fc
L_8d105a:
	mov_s r1,0x0
L_8d105c:
	cmp_s r0,0x11
L_8d105e:
	cmp.ne r0,0x12
L_8d1062:
	mov.ne r0,r1
L_8d1066:
	bne_s L_8d106a
L_8d1068:
	mov_s r0,0x1
	.global L_8d106a
L_8d106a:
	extb_s r0,r0
L_8d106c:
	pop_s blink
L_8d106e:
	j_s [blink]
