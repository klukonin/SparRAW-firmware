/* pbss__sta_flags_ptr @ 0x8de3c8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pbss_sta_list_update
 */
	.section .text.pbss__sta_flags_ptr,"ax",@progbits
	.global pbss__sta_flags_ptr
pbss__sta_flags_ptr:
	.global L_8de3c8
L_8de3c8:
	mul64 r1,0x11
L_8de3cc:
	add_s r0,r0,0x75
L_8de3ce:
	mov_s r2,0x8
L_8de3d0:
	add_s r0,r0,mlo
L_8de3d2:
	j_s.d [blink]
