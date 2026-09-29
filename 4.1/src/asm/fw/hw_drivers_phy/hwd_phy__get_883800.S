/* hwd_phy__get_883800 @ 0x8cf8cc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy_monitor__task_step
 */
	.section .text.hwd_phy__get_883800,"ax",@progbits
	.global hwd_phy__get_883800
hwd_phy__get_883800:
	.global L_8cf8cc
L_8cf8cc:
	mov_s r0,0x883800
L_8cf8d2:
	ld_s r0,[r0,0x30]
L_8cf8d4:
	j_s.d [blink]
L_8cf8d6:
	bmsk_s r0,r0,0x6
