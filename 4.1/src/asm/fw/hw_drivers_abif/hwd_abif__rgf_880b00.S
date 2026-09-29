/* hwd_abif__rgf_880b00 @ 0x8cd1ac, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm__apply_mode_flags
 */
	.section .text.hwd_abif__rgf_880b00,"ax",@progbits
	.global hwd_abif__rgf_880b00
hwd_abif__rgf_880b00:
	.global L_8cd1ac
L_8cd1ac:
	mov r3,0x1b0
L_8cd1b0:
	mov_s r1,0x880b00
L_8cd1b6:
	cmp_s r0,0x0
L_8cd1b8:
	ld_s r0,[r1]
L_8cd1ba:
	mov r2,-0x1b1
L_8cd1be:
	and_s r0,r0,r2
L_8cd1c0:
	or.ne r0,r0,r3
L_8cd1c4:
	st_s r0,[r1]
L_8cd1c6:
	j_s [blink]
