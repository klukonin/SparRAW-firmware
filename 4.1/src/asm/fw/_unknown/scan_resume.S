/* scan_resume @ 0x8f00d4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_resume()
 *   scan_resume() resumed on MID#%d.
 * Зовут его: frag_8f1908
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_log__emit1, scan_mngr__resume_scan
 */
	.section .text.scan_resume,"ax",@progbits
	.global scan_resume
scan_resume:
	.global L_8f00d4
L_8f00d4:
	push_s blink
L_8f00d6:
	push_s r13
L_8f00d8:
	mov_s r13,r0
L_8f00da:
	mov_s r2,0x101262c
L_8f00e0:
	mov_s r0,0xc
L_8f00e2:
	bl.d L_8edfb0
L_8f00e6:
	mov_s r1,0x2
L_8f00e8:
	ld_s r0,[r13,0x8]
L_8f00ea:
	ld_s r0,[r0,0x78]
L_8f00ec:
	breq_s r0,0,L_8f0106
L_8f00ee:
	ld_s r3,[r13,0x4]
L_8f00f0:
	mov_s r2,0x101263c
L_8f00f6:
	mov_s r0,0xc
L_8f00f8:
	mov_s r1,0x2
L_8f00fa:
	bl.d L_8edfcc
L_8f00fe:
	ldb_s r3,[r3,0x10]
L_8f0100:
	bl.d L_8efcc0
L_8f0104:
	ld_s r0,[r13,0x8]
	.global L_8f0106
L_8f0106:
	.byte 0x39,0x02
