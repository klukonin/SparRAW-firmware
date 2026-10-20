/* led__update_by_link_rate @ 0x8da8cc, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__report
 * Зовёт сам: led_scheme__apply
 * Глобалы (через gp): 0x8003b4, 0x8003b8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global led__update_by_link_rate
led__update_by_link_rate:
	.global L_8da8cc
L_8da8cc:
	mov_s r1,r0
L_8da8ce:
	ld_s r0,[gp,0x230]
L_8da8d0:
	cmp_s r1,r0
L_8da8d2:
	mov_s r0,0x3
L_8da8d4:
	bhi_s L_8da8e0
L_8da8d6:
	ld_s r0,[gp,0x234]
L_8da8d8:
	cmp_s r1,r0
L_8da8da:
	mov_s r0,0x2
L_8da8dc:
	mov.ls r0,0x1
	.global L_8da8e0
L_8da8e0:
	b L_8da84c
