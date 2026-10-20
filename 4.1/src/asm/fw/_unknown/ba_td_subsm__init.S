/* ba_td_subsm__init @ 0x8d5c4c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__init
 * Зовёт сам: basic_sm__setup
 * Глобалы (через gp): 0x8001c4
 */
	.section .text.ba_td_subsm__init,"ax",@progbits
	.global ba_td_subsm__init
ba_td_subsm__init:
	.global L_8d5c4c
L_8d5c4c:
	mov_s r2,0x0
L_8d5c4e:
	stb r2,[r0, 0x2c]
L_8d5c52:
	st_s r1,[r0,0x34]
L_8d5c54:
	mov r4,0x801148
L_8d5c5c:
	mov r5,0x801158
L_8d5c64:
	ld.as r1,[gp,0x15]
L_8d5c68:
	mov_s r3,0x802568
L_8d5c6e:
	mov r6,0x4
L_8d5c72:
	b.d L_8d6478
L_8d5c76:
	mov r7,0x3
L_8d5c7a:
	nop_s
