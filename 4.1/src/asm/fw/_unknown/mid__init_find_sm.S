/* mid__init_find_sm @ 0x8d653c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__open_reset_state
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, find_main_sm__init, mid_list__by_mid
 * Глобалы (через gp): 0x800225
 */
	.section .text.mid__init_find_sm,"ax",@progbits
	.global mid__init_find_sm
mid__init_find_sm:
	.global L_8d653c
L_8d653c:
	push_s blink
L_8d653e:
	bl L_8c02c4
L_8d6542:
	mov_s r13,r0
L_8d6544:
	add_s r0,r0,0x1c
L_8d6546:
	bl.d L_8ed1c0
L_8d654a:
	mov_s r1,r13
L_8d654c:
	mov_s r14,0x0
L_8d654e:
	bl.d L_8ca1b0
L_8d6552:
	mov_s r0,r14
L_8d6554:
	st_s r0,[r13,0x6c]
L_8d6556:
	mov_s r0,0x1
L_8d6558:
	st_s r0,[r13,0xc]
L_8d655a:
	ldb_s r0,[gp,0xb5]
L_8d655c:
	st_s r14,[r13,0x64]
L_8d655e:
	stb_s r0,[r13,0x10]
L_8d6560:
	st_s r14,[r13,0x18]
L_8d6562:
	b.d L_8c0334
L_8d6566:
	st_s r14,[r13,0x68]
