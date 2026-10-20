/* bss_bi_ctrl_PCP_ready_set @ 0x8c4be8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [BSS] bss_bi_ctrl_PCP_ready_set %d ! <<<< security_en = %d >>>>
 * Зовут его: assoc_ready_check_trig, bcon_tx_build_step
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bits__set8_s4_w2, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bss_bi_ctrl_PCP_ready_set
bss_bi_ctrl_PCP_ready_set:
	.global L_8c4be8
L_8c4be8:
	push_s blink
L_8c4bea:
	bl L_8c01e0
L_8c4bee:
	mov_s r15,r0
L_8c4bf0:
	mov_s r14,r1
L_8c4bf2:
	mov_s r1,0x100c3dc
L_8c4bf8:
	mov_s r3,0x803b80
L_8c4bfe:
	mov_s r0,0x2b
L_8c4c00:
	mov_s r2,r14
L_8c4c02:
	bl.d L_8dcc80
L_8c4c06:
	ld_s r3,[r3,0x6c]
L_8c4c08:
	cmp_s r14,0x1
L_8c4c0a:
	mov_s r1,0x1
L_8c4c0c:
	sub_s.ne r1,r1,r1
L_8c4c0e:
	add3 r13,r15,0x20
L_8c4c12:
	add r0,r13,0xc
L_8c4c16:
	bl L_8ed298
L_8c4c1a:
	b L_8c024c
L_8c4c1e:
	nop_s
