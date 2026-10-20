/* pcie_serdes_step @ 0x8eaa64, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_pcie_config_lnkctl, hwd_pcie_l1_pm_sub_ctl_get, hwd_pcie_l1_sub_timing_config, pcie__fix_max_read_req, pcie__force_clear_l0s, pcie__l1_latency_wa
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, get_reg_882650, pcie__ack_882644, set_reg_882600, set_reg_88264c
 */
	.section .text.pcie_serdes_step,"ax",@progbits
	.global pcie_serdes_step
pcie_serdes_step:
	.global L_8eaa64
L_8eaa64:
	push_s blink
L_8eaa66:
	bl L_8c02b0
L_8eaa6a:
	mov_s r14,r1
L_8eaa6c:
	mov_s r16,r2
L_8eaa6e:
	mov_s r15,r3
L_8eaa70:
	mov r17,r4
L_8eaa74:
	mov r19,r5
L_8eaa78:
	mov r18,r6
L_8eaa7c:
	bl.d L_8ce4dc
L_8eaa80:
	mov_s r13,0x0
L_8eaa82:
	brne_s r15,0,L_8eaa96
L_8eaa84:
	brne r16,0x0,L_8eaa9c
L_8eaa88:
	breq_s r14,0,L_8eaa96
L_8eaa8a:
	breq r14,0x1,L_8eaa9a
L_8eaa8e:
	brne r14,0x2,L_8eaae0
L_8eaa92:
	mov_s r13,0x4
L_8eaa94:
	b_s L_8eaa9c
	.global L_8eaa96
L_8eaa96:
	mov_s r13,0x1
L_8eaa98:
	b_s L_8eaa9c
	.global L_8eaa9a
L_8eaa9a:
	mov_s r13,0x2
	.global L_8eaa9c
L_8eaa9c:
	bmsk r1,r13,0x2
L_8eaaa0:
	bmsk r0,r16,0x0
L_8eaaa4:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_8eaaa6:
	or_s r1,r1,r0
L_8eaaa8:
	bmsk_s r15,r15,0x0
L_8eaaaa:
	/* asl_s r15,r15,0x4 */
	.byte 0x04,0xbf
L_8eaaac:
	or_s r1,r1,r15
L_8eaaae:
	bmsk r0,r17,0x1
L_8eaab2:
	/* asl_s r0,r0,0x5 */
	.byte 0x05,0xb8
L_8eaab4:
	or_s r1,r1,r0
L_8eaab6:
	bmsk r0,r19,0x0
L_8eaaba:
	asl_s r0,r0,0xb
L_8eaabc:
	or_s r1,r1,r0
L_8eaabe:
	mov_s r13,0x0
L_8eaac0:
	mov_s r0,r13
L_8eaac2:
	and r1,r1,0x87f
L_8eaaca:
	bl.d L_8ce4e8
L_8eaace:
	mov_s r2,r13
L_8eaad0:
	bl L_8eec3c
L_8eaad4:
	breq_s r0,0,L_8eaae0
L_8eaad6:
	bl.d L_8ce75c
L_8eaada:
	mov_s r13,0x1
L_8eaadc:
	st r0,[r18]
	.global L_8eaae0
L_8eaae0:
	b.d L_8c030c
L_8eaae4:
	mov_s r0,r13
L_8eaae6:
	nop_s
