/* hwd_phy__get_883700_8cf97c @ 0x8cf97c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy_monitor__task_step
 */
	.section .text.hwd_phy__get_883700_8cf97c,"ax",@progbits
	.global hwd_phy__get_883700_8cf97c
hwd_phy__get_883700_8cf97c:
	.global L_8cf97c
L_8cf97c:
	mov_s r0,0x883700
L_8cf982:
	ld_s r0,[r0,0x8]
L_8cf984:
	j_s.d [blink]
L_8cf986:
	bmsk_s r0,r0,0x5
