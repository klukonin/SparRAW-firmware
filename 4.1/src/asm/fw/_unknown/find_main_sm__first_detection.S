/* find_main_sm__first_detection @ 0x8eb8dc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_main_sm::first_detection()
 * Зовут его: find_mngr__detect_discovery_bcon
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, search_scan_elem_in_list
 */
	.section .text.find_main_sm__first_detection,"ax",@progbits
	.global find_main_sm__first_detection
find_main_sm__first_detection:
	.global L_8eb8dc
L_8eb8dc:
	push_s blink
L_8eb8de:
	bl L_8c02c4
L_8eb8e2:
	mov_s r13,r0
L_8eb8e4:
	mov_s r14,r1
L_8eb8e6:
	mov_s r2,0x101465c
L_8eb8ec:
	mov_s r0,0xc
L_8eb8ee:
	bl.d L_8edfb0
L_8eb8f2:
	mov_s r1,0x2
L_8eb8f4:
	add r0,r13,0x3c
L_8eb8f8:
	bl.d L_8f020c
L_8eb8fc:
	mov_s r1,r14
L_8eb8fe:
	cmp_s r0,0x0
L_8eb900:
	mov_s r0,0x1
L_8eb902:
	b.d L_8c0334
L_8eb906:
	sub_s.ne r0,r0,r0
