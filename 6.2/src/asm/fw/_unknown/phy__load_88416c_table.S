/* phy__load_88416c_table @ 0x8d46e4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mngr__check_mode
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy__load_88416c_table
phy__load_88416c_table:
	.global L_8d46e4
L_8d46e4:
	mov lp_count,0x54
L_8d46e8:
	mov_s r1,0x0
L_8d46ea:
	lp L_8d4704
L_8d46ee:
	mov_s r0,0x803838
L_8d46f4:
	ldw.as r2,[r0,r1]
L_8d46f8:
	mov_s r0,0x88416c
L_8d46fe:
	add2_s r0,r0,r1
L_8d4700:
	st_s r2,[r0]
L_8d4702:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8d4704
L_8d4704:
	j_s [blink]
L_8d4706:
	nop_s
