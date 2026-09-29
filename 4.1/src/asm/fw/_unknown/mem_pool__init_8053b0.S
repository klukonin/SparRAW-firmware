/* mem_pool__init_8053b0 @ 0x8c1980, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: mem_pool__create
 */
	.section .text.mem_pool__init_8053b0,"ax",@progbits
	.global mem_pool__init_8053b0
mem_pool__init_8053b0:
L_8c1980:
	mov_s r0,0x8053b0
L_8c1986:
	mov_s r3,0x28128
L_8c198c:
	mov_s r1,0x8
L_8c198e:
	mov_s r2,0xa4
L_8c1990:
	b.d L_8c16d0
L_8c1994:
	mov r4,0x402
L_8c1998:
	mov_s r1,0x8058f0
L_8c199e:
	mov_s r0,0x8006ac
L_8c19a4:
	j_s.d [blink]
L_8c19a6:
	.byte 0x8d,0x19
