/* pbss__sta_entry_flag @ 0x8ca7c4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pbss_sta_list_update
 */
	.section .text.pbss__sta_entry_flag,"ax",@progbits
	.global pbss__sta_entry_flag
pbss__sta_entry_flag:
	.global L_8ca7c4
L_8ca7c4:
	mul64 r1,0x11
L_8ca7c8:
	mov_s r2,r0
L_8ca7ca:
	add_s r2,r2,0x75
L_8ca7cc:
	ldb r2,[r2,mlo]
L_8ca7d0:
	cmp_s r1,r2
L_8ca7d2:
	add_s r0,r0,0x6f
L_8ca7d4:
	add.eq r0,r0,mlo
L_8ca7d8:
	sub_s.ne r0,r0,r0
L_8ca7da:
	j_s [blink]
