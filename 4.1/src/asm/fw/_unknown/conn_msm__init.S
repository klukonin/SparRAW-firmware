/* conn_msm__init @ 0x8d5b1c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: connection__init
 * Зовёт сам: __ld_r13_ret, basic_sm__setup, disconn_sm__init
 * Глобалы (через gp): 0x8001b4
 */
	.section .text.conn_msm__init,"ax",@progbits
	.global conn_msm__init
conn_msm__init:
	.global L_8d5b1c
L_8d5b1c:
	push_s blink
L_8d5b1e:
	push_s r13
L_8d5b20:
	mov_s r13,r0
L_8d5b22:
	st_s r1,[r0,0x2c]
L_8d5b24:
	mov_s r0,0x0
L_8d5b26:
	st_s r0,[r13,0x74]
L_8d5b28:
	st_s r0,[r13,0x78]
L_8d5b2a:
	mov r4,0x801050
L_8d5b32:
	mov r5,0x80107c
L_8d5b3a:
	mov_s r0,r13
L_8d5b3c:
	ld.as r1,[gp,0x11]
L_8d5b40:
	mov_s r2,0x0
L_8d5b42:
	mov_s r3,0x802008
L_8d5b48:
	mov r6,0xb
L_8d5b4c:
	bl.d L_8d6478
L_8d5b50:
	mov r7,0x9
L_8d5b54:
	mov_s r0,0x1
L_8d5b56:
	st_s r0,[r13,0x28]
L_8d5b58:
	add r0,r13,0x30
L_8d5b5c:
	bl.d L_8ed188
L_8d5b60:
	mov_s r1,r13
L_8d5b62:
	b L_8c033c
L_8d5b66:
	nop_s
