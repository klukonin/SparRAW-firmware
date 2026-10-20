/* bss_bi_ctrl_PCP_ready_set @ 0x8c4298, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [BSS] bss_bi_ctrl_PCP_ready_set %d ! <<<< security_en = %d >>>>
 * Зовут его: assoc_ready_check_trig, bcon_tx_build_step
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_b_s4_w2, fw_log__emit2
 */
	.section .text.bss_bi_ctrl_PCP_ready_set,"ax",@progbits
	.global bss_bi_ctrl_PCP_ready_set
bss_bi_ctrl_PCP_ready_set:
	.global L_8c4298
L_8c4298:
	push_s blink
L_8c429a:
	bl L_8c02c0
L_8c429e:
	mov_s r15,r0
L_8c42a0:
	mov_s r13,r1
L_8c42a2:
	mov_s r2,0x100af58
L_8c42a8:
	mov_s r0,0x8033dc
L_8c42ae:
	ld r4,[r0, 0x6c]
L_8c42b2:
	mov_s r0,0xb
L_8c42b4:
	mov_s r1,0x2
L_8c42b6:
	bl.d L_8edff8
L_8c42ba:
	mov_s r3,r13
L_8c42bc:
	cmp_s r13,0x1
L_8c42be:
	mov_s r1,0x1
L_8c42c0:
	sub_s.ne r1,r1,r1
L_8c42c2:
	add3 r14,r15,0x20
L_8c42c6:
	add r0,r14,0xc
L_8c42ca:
	bl L_8e8264
L_8c42ce:
	b L_8c032c
L_8c42d2:
	nop_s
