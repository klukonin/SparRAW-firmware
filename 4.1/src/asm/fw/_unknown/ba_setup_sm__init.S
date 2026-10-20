/* ba_setup_sm__init @ 0x8ed0d0, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__init
 * Зовёт сам: __ld_r13_ret, basic_sm__setup
 * Глобалы (через gp): 0x8001c0
 */
	.section .text.ba_setup_sm__init,"ax",@progbits
	.global ba_setup_sm__init
ba_setup_sm__init:
	.global L_8ed0d0
L_8ed0d0:
	push_s blink
L_8ed0d2:
	push_s r13
L_8ed0d4:
	mov_s r13,r0
L_8ed0d6:
	mov_s r0,0x0
L_8ed0d8:
	st_s r0,[r13,0x30]
L_8ed0da:
	st_s r0,[r13,0x38]
L_8ed0dc:
	stb r0,[r13, 0x2d]
L_8ed0e0:
	st_s r1,[r13,0x44]
L_8ed0e2:
	mov r4,0x801100
L_8ed0ea:
	mov r5,0x801130
L_8ed0f2:
	mov_s r0,r13
L_8ed0f4:
	ld.as r1,[gp,0x14]
L_8ed0f8:
	mov_s r2,0x0
L_8ed0fa:
	mov_s r3,0x802400
L_8ed100:
	mov r6,0xc
L_8ed104:
	bl.d L_8d6478
L_8ed108:
	mov r7,0x6
L_8ed10c:
	mov_s r0,0x1
L_8ed10e:
	b.d L_8c033c
L_8ed112:
	st_s r0,[r13,0x28]
