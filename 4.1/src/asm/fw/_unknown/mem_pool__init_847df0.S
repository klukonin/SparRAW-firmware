/* mem_pool__init_847df0 @ 0x8c19e4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: mem_pool__create
 */
	.section .text.mem_pool__init_847df0,"ax",@progbits
	.global mem_pool__init_847df0
mem_pool__init_847df0:
L_8c19e4:
	mov_s r3,0x2815c
L_8c19ea:
	mov_s r0,0x847df0
L_8c19f0:
	mov_s r1,0x9
L_8c19f2:
	mov_s r2,0xe4
L_8c19f4:
	b.d L_8c16d0
L_8c19f8:
	mov r4,0x402
L_8c19fc:
	mov_s r1,0x806740
L_8c1a02:
	mov_s r0,0x8005d4
L_8c1a08:
	st_s r0,[r1,0x8]
L_8c1a0a:
	mov_s r0,0x800634
L_8c1a10:
	j_s.d [blink]
L_8c1a12:
	st_s r0,[r1,0x14]
