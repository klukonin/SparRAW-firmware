/* find_mngr__enter_search @ 0x8f01ac, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   search()
 *   discovery.cpp
 * Зовут его: l2_mgr__wmi_cmd_handler_start_search_8f33b8
 * Зовёт сам: __ld_r13_ret, find_mng__search, fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.find_mngr__enter_search,"ax",@progbits
	.global find_mngr__enter_search
find_mngr__enter_search:
	.global L_8f01ac
L_8f01ac:
	push_s blink
L_8f01ae:
	push_s r13
L_8f01b0:
	mov_s r13,r0
L_8f01b2:
	mov_s r2,0x1012830
L_8f01b8:
	mov_s r0,0xc
L_8f01ba:
	bl.d L_8edfb0
L_8f01be:
	mov_s r1,0x2
L_8f01c0:
	ld_s r0,[r13,0x8]
L_8f01c2:
	ld_s r0,[r0,0x78]
L_8f01c4:
	brne_s r0,0,L_8f01da
	.global L_8f01c6
L_8f01c6:
	ld_s r0,[r13,0x4]
L_8f01c8:
	ld_s r0,[r0,0x4c]
L_8f01ca:
	brne r0,0x1,L_8f01f2
	.global L_8f01ce
L_8f01ce:
	bl.d L_8e0098
L_8f01d2:
	add r0,r13,0xc
L_8f01d6:
	b L_8c033c
	.global L_8f01da
L_8f01da:
	mov_s r0,blink
L_8f01dc:
	mov_s r2,0x1012024
L_8f01e2:
	mov_s r1,0x1239
L_8f01e8:
	bl.d L_8c82c0
L_8f01ec:
	mov r3,0x1fa
L_8f01f0:
	b_s L_8f01c6
	.global L_8f01f2
L_8f01f2:
	mov_s r0,blink
L_8f01f4:
	mov_s r2,0x1012024
L_8f01fa:
	mov_s r1,0x123a
L_8f0200:
	bl.d L_8c82c0
L_8f0204:
	mov r3,0x1fb
L_8f0208:
	b_s L_8f01ce
L_8f020a:
	nop_s
