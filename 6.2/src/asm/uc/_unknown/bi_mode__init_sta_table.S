/* bi_mode__init_sta_table @ 0x93b908, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 * Зовёт сам: memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_mode__init_sta_table
bi_mode__init_sta_table:
	.global L_93b908
L_93b908:
	mov_s r0,0x1f
L_93b90a:
	mov_s r1,0x802b10
L_93b910:
	st_s r0,[r1,0x4]
L_93b912:
	mov_s r0,0x11
L_93b914:
	st_s r0,[r1,0xc]
L_93b916:
	mov_s r0,0x802b68
L_93b91c:
	b.d L_920a84
L_93b920:
	mov r1,0x2ac
