/* alloc_dband_info @ 0x8e94a4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   alloc_dband_info()
 * Зовут его: find_main_sm__bcon, scan_mngr__dband_beacon_ind, scan_mngr__handle_abft_bf_result_in_scan
 * Зовёт сам: fw_log__emit0, mem_pool__allocate
 */
	.section .text.alloc_dband_info,"ax",@progbits
	.global alloc_dband_info
alloc_dband_info:
	.global L_8e94a4
L_8e94a4:
	push_s blink
L_8e94a6:
	mov_s r2,0x1012794
L_8e94ac:
	mov_s r0,0xd
L_8e94ae:
	bl.d L_8edfb0
L_8e94b2:
	mov_s r1,0x2
L_8e94b4:
	mov_s r0,0x843134
L_8e94ba:
	bl L_8c2dc8
L_8e94be:
	mov_s r1,0x0
L_8e94c0:
	stb r1,[r0, 0x3a]
L_8e94c4:
	pop_s blink
L_8e94c6:
	j_s [blink]
