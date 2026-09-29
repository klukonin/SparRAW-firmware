/* sta_psc_sm__init @ 0x8d5a0c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: psc_if__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__setup
 * Глобалы (через gp): 0x8001a4, 0x80040c
 */
	.section .text.sta_psc_sm__init,"ax",@progbits
	.global sta_psc_sm__init
sta_psc_sm__init:
	.global L_8d5a0c
L_8d5a0c:
	push_s blink
L_8d5a0e:
	bl.d L_8c02c4
L_8d5a12:
	mov r6,0x7
L_8d5a16:
	mov_s r13,r0
L_8d5a18:
	st_s r1,[r0,0x38]
L_8d5a1a:
	mov_s r14,0x0
L_8d5a1c:
	stb r14,[r0, 0x34]
L_8d5a20:
	st_s r14,[r0,0x2c]
L_8d5a22:
	st_s r14,[r0,0x30]
L_8d5a24:
	mov r4,0x800aac
L_8d5a2c:
	ld.as r1,[gp,0xd]
L_8d5a30:
	mov_s r2,r14
L_8d5a32:
	mov_s r3,0x801b04
L_8d5a38:
	mov r5,0x800484
L_8d5a40:
	bl.d L_8d6478
L_8d5a44:
	mov r7,0x2
L_8d5a48:
	ld_s r0,[gp,0x29c]
L_8d5a4a:
	breq_s r0,0,L_8d5a52
L_8d5a4c:
	mov_s r0,0x1
L_8d5a4e:
	st_s r0,[r13,0x28]
L_8d5a50:
	b_s L_8d5a54
	.global L_8d5a52
L_8d5a52:
	st_s r14,[r13,0x28]
	.global L_8d5a54
L_8d5a54:
	b L_8c0334
