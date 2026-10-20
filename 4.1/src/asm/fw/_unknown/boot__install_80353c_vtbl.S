/* boot__install_80353c_vtbl @ 0x8c19bc, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.boot__install_80353c_vtbl,"ax",@progbits
	.global boot__install_80353c_vtbl
boot__install_80353c_vtbl:
L_8c19bc:
	mov_s r1,0x80353c
L_8c19c2:
	mov_s r0,0x8007cc
L_8c19c8:
	st_s r0,[r1,0x74]
L_8c19ca:
	mov_s r0,0x8007a0
L_8c19d0:
	st_s r0,[r1,0x44]
L_8c19d2:
	mov_s r0,0x800784
L_8c19d8:
	st_s r0,[r1,0x38]
L_8c19da:
	mov_s r0,0x800758
L_8c19e0:
	j_s.d [blink]
L_8c19e2:
	st_s r0,[r1,0x8]
