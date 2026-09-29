/* hwd_abif__rgf_880b00 @ 0x8d00cc, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm__apply_mode_flags
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rgf_880b00
hwd_abif__rgf_880b00:
	.global L_8d00cc
L_8d00cc:
	mov r3,0x1b0
L_8d00d0:
	mov_s r1,0x880b00
L_8d00d6:
	cmp_s r0,0x0
L_8d00d8:
	ld_s r0,[r1]
L_8d00da:
	mov r2,-0x1b1
L_8d00de:
	and_s r0,r0,r2
L_8d00e0:
	or.ne r0,r0,r3
L_8d00e4:
	st_s r0,[r1]
L_8d00e6:
	j_s [blink]
