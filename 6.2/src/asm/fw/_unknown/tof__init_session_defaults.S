/* tof__init_session_defaults @ 0x8e64bc, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tof__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tof__init_session_defaults
tof__init_session_defaults:
	.global L_8e64bc
L_8e64bc:
	mov_s r1,0x1
L_8e64be:
	add r2,r0,0x20
L_8e64c2:
	stb_s r1,[r2,0x4]
L_8e64c4:
	stb_s r1,[r2,0x5]
L_8e64c6:
	mov_s r1,0x4
L_8e64c8:
	stb_s r1,[r2,0x6]
L_8e64ca:
	mov_s r1,0x0
L_8e64cc:
	stw_s r1,[r0,0x28]
L_8e64ce:
	mov_s r2,0x2
L_8e64d0:
	stw_s r2,[r0,0x2a]
L_8e64d2:
	st_s r1,[r0,0x2c]
L_8e64d4:
	st_s r1,[r0,0x30]
L_8e64d6:
	st_s r2,[r0,0x34]
L_8e64d8:
	st_s r1,[r0,0x38]
L_8e64da:
	j_s.d [blink]
L_8e64dc:
	st_s r1,[r0,0x3c]
L_8e64de:
	nop_s
