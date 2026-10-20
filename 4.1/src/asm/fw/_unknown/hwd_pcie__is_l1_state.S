/* hwd_pcie__is_l1_state @ 0x8ce310, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_pcie_exit_l1, pcie__l1_dwell_stats, pcie__pm_host_config
 * Зовёт сам: hwd_pcie__get_ltssm_state
 */
	.section .text.hwd_pcie__is_l1_state,"ax",@progbits
	.global hwd_pcie__is_l1_state
hwd_pcie__is_l1_state:
	.global L_8ce310
L_8ce310:
	push_s blink
L_8ce312:
	bl L_8ce700
L_8ce316:
	mov_s r1,0x0
L_8ce318:
	cmp_s r0,0x11
L_8ce31a:
	cmp.ne r0,0x12
L_8ce31e:
	mov.ne r0,r1
L_8ce322:
	bne_s L_8ce326
L_8ce324:
	mov_s r0,0x1
	.global L_8ce326
L_8ce326:
	extb_s r0,r0
L_8ce328:
	pop_s blink
L_8ce32a:
	j_s [blink]
