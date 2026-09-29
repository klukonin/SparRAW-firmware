/* pbss__free_sta_slot @ 0x8c7594, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pbss__del_sta
 */
	.section .text.pbss__free_sta_slot,"ax",@progbits
	.global pbss__free_sta_slot
pbss__free_sta_slot:
	.global L_8c7594
L_8c7594:
	mul64 r1,0x11
L_8c7598:
	add_s r0,r0,0x60
L_8c759a:
	add_s r0,r0,mlo
L_8c759c:
	ldb_s r2,[r0,0x15]
L_8c759e:
	brne r1,r2,L_8c75a6
L_8c75a2:
	mov_s r1,0x8
L_8c75a4:
	stb_s r1,[r0,0x15]
	.global L_8c75a6
L_8c75a6:
	j_s [blink]
