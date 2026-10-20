/* pbss__free_sta_slot @ 0x8c8c04, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pbss__del_sta
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pbss__free_sta_slot
pbss__free_sta_slot:
	.global L_8c8c04
L_8c8c04:
	mul64 r1,0x11
L_8c8c08:
	add_s r0,r0,0x60
L_8c8c0a:
	add_s r0,r0,mlo
L_8c8c0c:
	ldb_s r2,[r0,0x15]
L_8c8c0e:
	brne r1,r2,L_8c8c16
L_8c8c12:
	mov_s r1,0x8
L_8c8c14:
	stb_s r1,[r0,0x15]
	.global L_8c8c16
L_8c8c16:
	j_s [blink]
