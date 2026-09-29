/* led__update_by_link_rate @ 0x8d77e4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__report
 * Зовёт сам: led_scheme__apply
 * Глобалы (через gp): 0x800394, 0x800398
 */
	.section .text.led__update_by_link_rate,"ax",@progbits
	.global led__update_by_link_rate
led__update_by_link_rate:
	.global L_8d77e4
L_8d77e4:
	mov_s r1,r0
L_8d77e6:
	ld_s r0,[gp,0x224]
L_8d77e8:
	cmp_s r1,r0
L_8d77ea:
	mov_s r0,0x3
L_8d77ec:
	bhi_s L_8d77f8
L_8d77ee:
	ld_s r0,[gp,0x228]
L_8d77f0:
	cmp_s r1,r0
L_8d77f2:
	mov_s r0,0x2
L_8d77f4:
	mov.ls r0,0x1
	.global L_8d77f8
L_8d77f8:
	b L_8d775c
