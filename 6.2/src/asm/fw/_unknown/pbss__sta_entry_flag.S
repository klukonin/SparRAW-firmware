/* pbss__sta_entry_flag @ 0x8cc9b0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pbss_sta_list_update
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pbss__sta_entry_flag
pbss__sta_entry_flag:
	.global L_8cc9b0
L_8cc9b0:
	mul64 r1,0x11
L_8cc9b4:
	mov_s r2,r0
L_8cc9b6:
	add_s r2,r2,0x75
L_8cc9b8:
	ldb r2,[r2,mlo]
L_8cc9bc:
	cmp_s r1,r2
L_8cc9be:
	add_s r0,r0,0x6f
L_8cc9c0:
	add.eq r0,r0,mlo
L_8cc9c4:
	sub_s.ne r0,r0,r0
L_8cc9c6:
	j_s [blink]
