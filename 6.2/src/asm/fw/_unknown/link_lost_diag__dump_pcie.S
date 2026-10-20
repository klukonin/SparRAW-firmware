/* link_lost_diag__dump_pcie @ 0x8c8638, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEBUG PCIE: L1 STATE:%d, L1SS STATE:0x%x LTSSM STATE:0x%x
 *   DEBUG PCIE: APP DEBUG IF: 0x%x
 * Зовут его: link_lost_diag__dump_all
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_log_emit3, hwd_pcie__get_88b0c0_state4, hwd_pcie__get_ltssm_state, hwd_pcie_ltssm_is_l1_idle, pcie__read_app_debug_if
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_lost_diag__dump_pcie
link_lost_diag__dump_pcie:
	.global L_8c8638
L_8c8638:
	push_s blink
L_8c863a:
	bl L_8c01e4
L_8c863e:
	bl L_8d1070
L_8c8642:
	bl.d L_8d13ec
L_8c8646:
	mov_s r14,r0
L_8c8648:
	bl.d L_8d13fc
L_8c864c:
	mov_s r13,r0
L_8c864e:
	mov_s r4,r0
L_8c8650:
	mov_s r1,0x10010b8
L_8c8656:
	mov_s r0,0x20
L_8c8658:
	mov_s r2,r14
L_8c865a:
	bl.d L_8dcd00
L_8c865e:
	mov_s r3,r13
L_8c8660:
	bl L_8d13a4
L_8c8664:
	mov_s r1,0x10010f4
L_8c866a:
	mov_s r2,r0
L_8c866c:
	bl.d L_8dcc10
L_8c8670:
	mov_s r0,0x20
L_8c8672:
	b L_8c0254
L_8c8676:
	nop_s
