/* find_main_sm__init @ 0x8ed1c0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__init_find_sm
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__setup
 * Глобалы (через gp): 0x8001cc
 */
	.section .text.find_main_sm__init,"ax",@progbits
	.global find_main_sm__init
find_main_sm__init:
	.global L_8ed1c0
L_8ed1c0:
	push_s blink
L_8ed1c2:
	bl.d L_8c02c0
L_8ed1c6:
	mov r6,0x7
L_8ed1ca:
	mov_s r13,r0
L_8ed1cc:
	mov_s r14,r1
L_8ed1ce:
	mov r4,0x801440
L_8ed1d6:
	mov r5,0x80145c
L_8ed1de:
	ld.as r1,[gp,0x17]
L_8ed1e2:
	mov_s r15,0x0
L_8ed1e4:
	mov_s r2,r15
L_8ed1e6:
	mov_s r3,0x802a5c
L_8ed1ec:
	bl.d L_8d6478
L_8ed1f0:
	mov r7,0x5
L_8ed1f4:
	st_s r14,[r13,0x34]
L_8ed1f6:
	st_s r15,[r13,0x38]
L_8ed1f8:
	mov_s r0,0x1
L_8ed1fa:
	b.d L_8c032c
L_8ed1fe:
	st_s r0,[r13,0x28]
