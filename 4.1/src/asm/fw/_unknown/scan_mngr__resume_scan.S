/* scan_mngr__resume_scan @ 0x8efcc0, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::resume_scan()
 * Зовут его: scan_resume
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.scan_mngr__resume_scan,"ax",@progbits
	.global scan_mngr__resume_scan
scan_mngr__resume_scan:
	.global L_8efcc0
L_8efcc0:
	push_s blink
L_8efcc2:
	push_s r13
L_8efcc4:
	mov_s r13,r0
L_8efcc6:
	mov_s r2,0x1012e0c
L_8efccc:
	mov_s r0,0x9
L_8efcce:
	bl.d L_8edfb0
L_8efcd2:
	mov_s r1,0x2
L_8efcd4:
	mov_s r1,0x0
L_8efcd6:
	st r1,[r13, 0x80]
L_8efcda:
	ld r0,[r13, 0x84]
L_8efcde:
	mov_s r2,r1
L_8efce0:
	mov_s r3,r1
L_8efce2:
	bl.d L_8d6a1c
L_8efce6:
	mov_s r4,r1
L_8efce8:
	b L_8c033c
