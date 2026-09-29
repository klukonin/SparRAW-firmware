/* calib_engine__on_abort @ 0x8c1b14, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: RADIO_MGR__remove_request, __ld_r13_ret, u_schd__cancel
 */
	.section .text.calib_engine__on_abort,"ax",@progbits
	.global calib_engine__on_abort
calib_engine__on_abort:
L_8c1b14:
	push_s blink
L_8c1b16:
	push_s r13
L_8c1b18:
	mov_s r13,r0
L_8c1b1a:
	ld_s r0,[r0,0x48]
L_8c1b1c:
	breq_s r0,0,L_8c1b26
L_8c1b1e:
	bl L_8de444
L_8c1b22:
	mov_s r0,0x0
L_8c1b24:
	st_s r0,[r13,0x48]
	.global L_8c1b26
L_8c1b26:
	ld_s r0,[r13,0x4c]
L_8c1b28:
	breq_s r0,0,L_8c1b32
L_8c1b2a:
	bl L_8c7794
L_8c1b2e:
	mov_s r0,0x0
L_8c1b30:
	st_s r0,[r13,0x4c]
	.global L_8c1b32
L_8c1b32:
	b L_8c033c
L_8c1b36:
	nop_s
