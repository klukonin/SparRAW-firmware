/* uc_basic_sm__setup @ 0x928174, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_ap_mon__init
 */
	.section .text.uc_basic_sm__setup,"ax",@progbits
	.global uc_basic_sm__setup
uc_basic_sm__setup:
	.global L_928174
L_928174:
	stb_s r2,[r0]
L_928176:
	st_s r1,[r0,0x24]
L_928178:
	st_s r3,[r0,0x18]
L_92817a:
	st r5,[r0, 0x1c]
L_92817e:
	st r4,[r0, 0x20]
L_928182:
	stb r6,[r0, 0x1]
L_928186:
	stb r7,[r0, 0x2]
L_92818a:
	mov_s r2,0x0
L_92818c:
	st_s r2,[r0,0x4]
L_92818e:
	j_s.d [blink]
L_928190:
	st_s r2,[r0,0x28]
L_928192:
	nop_s
