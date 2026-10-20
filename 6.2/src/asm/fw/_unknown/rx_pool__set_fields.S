/* rx_pool__set_fields @ 0x8d9394, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_pool__configure_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_pool__set_fields
rx_pool__set_fields:
	.global L_8d9394
L_8d9394:
	st_s r1,[r0]
L_8d9396:
	st_s r2,[r0,0x4]
L_8d9398:
	mov_s r1,0x0
L_8d939a:
	st_s r1,[r0,0x8]
L_8d939c:
	j_s.d [blink]
L_8d939e:
	st_s r1,[r0,0xc]
