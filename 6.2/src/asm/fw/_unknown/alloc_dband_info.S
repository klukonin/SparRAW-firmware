/* alloc_dband_info @ 0x8f0cf8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   alloc_dband_info()
 * Зовут его: find_main_sm__bcon, scan_mngr__dband_beacon_ind, scan_mngr__handle_abft_bf_result_in_scan
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, mem_pool__allocate, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global alloc_dband_info
alloc_dband_info:
	.global L_8f0cf8
L_8f0cf8:
	push_s blink
L_8f0cfa:
	push_s r13
L_8f0cfc:
	mov_s r1,0x1016f70
L_8f0d02:
	bl.d L_8dcba8
L_8f0d06:
	mov_s r0,0x2d
L_8f0d08:
	mov_s r0,0x805524
L_8f0d0e:
	bl L_8c354c
L_8f0d12:
	mov.f r13,r0
L_8f0d16:
	mov.ne r1,0x4c
L_8f0d1e:
	bl.ne L_8c1cd8
L_8f0d22:
	b.d L_8c025c
L_8f0d26:
	mov_s r0,r13
