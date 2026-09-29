/* scan_mngr__stop_dwelling @ 0x8f1790, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::stop_dwelling()
 * Зовут его: l2_mgr__lmac_new_link_evt_handler
 * Зовёт сам: __ld_r13_ret, channels_switch_sm__action_abort_dwelling, fw_log__emit0
 */
	.section .text.scan_mngr__stop_dwelling,"ax",@progbits
	.global scan_mngr__stop_dwelling
scan_mngr__stop_dwelling:
	.global L_8f1790
L_8f1790:
	push_s blink
L_8f1792:
	push_s r13
L_8f1794:
	mov_s r13,r0
L_8f1796:
	mov_s r2,0x1013b4c
L_8f179c:
	mov_s r0,0x9
L_8f179e:
	bl.d L_8edfb0
L_8f17a2:
	mov_s r1,0x2
L_8f17a4:
	ld r0,[r13, 0x84]
L_8f17a8:
	mov_s r1,0x0
L_8f17aa:
	mov_s r2,r1
L_8f17ac:
	bl.d L_8e8f00
L_8f17b0:
	mov_s r3,r1
L_8f17b2:
	b L_8c033c
L_8f17b6:
	nop_s
