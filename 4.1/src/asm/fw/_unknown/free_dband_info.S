/* free_dband_info @ 0x8ebb88, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   free_dband_info()
 * Зовут его: find_main_sm__stop, find_sm__start_search, scan_mngr__clean_all_lists, scan_mngr__prob_done
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, mem_pool__free
 */
	.section .text.free_dband_info,"ax",@progbits
	.global free_dband_info
free_dband_info:
	.global L_8ebb88
L_8ebb88:
	push_s blink
L_8ebb8a:
	push_s r13
L_8ebb8c:
	mov_s r13,r0
L_8ebb8e:
	mov_s r2,0x10127a8
L_8ebb94:
	mov_s r0,0xd
L_8ebb96:
	bl.d L_8edfb0
L_8ebb9a:
	mov_s r1,0x2
L_8ebb9c:
	mov_s r0,0x843134
L_8ebba2:
	bl.d L_8c9268
L_8ebba6:
	mov_s r1,r13
L_8ebba8:
	b L_8c033c
