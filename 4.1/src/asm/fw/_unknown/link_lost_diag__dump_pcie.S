/* link_lost_diag__dump_pcie @ 0x8eae1c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEBUG PCIE: L1 STATE:%d, L1SS STATE:0x%x LTSSM STATE:0x%x
 *   DEBUG PCIE: APP DEBUG IF: 0x%x
 * Зовут его: link_lost_diag__dump_all
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, fw_log__emit3, get_reg88b0c0_s2_w32, hwd_pcie__get_ltssm_state, hwd_pcie_ltssm_is_l1_idle, pcie__read_error_counters
 */
	.section .text.link_lost_diag__dump_pcie,"ax",@progbits
	.global link_lost_diag__dump_pcie
link_lost_diag__dump_pcie:
	.global L_8eae1c
L_8eae1c:
	push_s blink
L_8eae1e:
	bl L_8c02c4
L_8eae22:
	bl L_8ce32c
L_8eae26:
	bl.d L_8ce6f0
L_8eae2a:
	mov_s r14,r0
L_8eae2c:
	bl.d L_8ce700
L_8eae30:
	mov_s r13,r0
L_8eae32:
	mov_s r5,r0
L_8eae34:
	mov_s r2,0x1000fc0
L_8eae3a:
	mov_s r0,0x0
L_8eae3c:
	mov_s r1,0x2
L_8eae3e:
	mov_s r3,r14
L_8eae40:
	bl.d L_8ee034
L_8eae44:
	mov_s r4,r13
L_8eae46:
	bl L_8ce6a8
L_8eae4a:
	mov_s r2,0x1000ffc
L_8eae50:
	mov_s r3,r0
L_8eae52:
	mov_s r0,0x0
L_8eae54:
	bl.d L_8edfcc
L_8eae58:
	mov_s r1,0x2
L_8eae5a:
	b L_8c0334
L_8eae5e:
	nop_s
