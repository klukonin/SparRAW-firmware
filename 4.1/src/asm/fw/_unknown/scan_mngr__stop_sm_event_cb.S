/* scan_mngr__stop_sm_event_cb @ 0x8f181c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::stop_sm_event_cb()
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.scan_mngr__stop_sm_event_cb,"ax",@progbits
	.global scan_mngr__stop_sm_event_cb
scan_mngr__stop_sm_event_cb:
L_8f181c:
	push_s blink
L_8f181e:
	push_s r13
L_8f1820:
	mov_s r13,r0
L_8f1822:
	mov_s r2,0x1013d6c
L_8f1828:
	mov_s r0,0x9
L_8f182a:
	bl.d L_8edfb0
L_8f182e:
	mov_s r1,0x2
L_8f1830:
	ld r0,[r13, 0x84]
L_8f1834:
	mov_s r1,0x5
L_8f1836:
	mov_s r2,0x0
L_8f1838:
	mov_s r3,r2
L_8f183a:
	bl.d L_8d6a1c
L_8f183e:
	mov_s r4,r2
L_8f1840:
	b L_8c033c
