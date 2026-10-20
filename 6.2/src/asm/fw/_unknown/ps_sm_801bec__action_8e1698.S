/* ps_sm_801bec__action_8e1698 @ 0x8e1698, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__handle_event, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_sm_801bec__action_8e1698
ps_sm_801bec__action_8e1698:
	.global L_8e1698
L_8e1698:
	mov_s r1,r0
L_8e169a:
	mov_s r0,L_8e15fc-0x8c0000
L_8e16a0:
	mov_s r2,0x0
L_8e16a2:
	b.d L_8c3248
L_8e16a6:
	mov_s r3,r2
L_8e16a8:
	ld_s r0,[gp,-0x64]
L_8e16aa:
	ld_s r1,[r0,0x8]
L_8e16ac:
	ld_s r1,[r1,0x1c]
L_8e16ae:
	j_s [r1]
L_8e16b0:
	mov_s r1,0x2
L_8e16b2:
	mov_s r2,r0
L_8e16b4:
	mov_s r3,0x0
L_8e16b6:
	b.d L_8d9b6c
L_8e16ba:
	mov_s r4,r3
L_8e16bc:
	add_s r0,r0,0xc
L_8e16be:
	ld_s r1,[r0,0x8]
L_8e16c0:
	ld_s r1,[r1,0x14]
L_8e16c2:
	j_s [r1]
L_8e16c4:
	mov_s r1,0x2
L_8e16c6:
	mov_s r2,r0
L_8e16c8:
	mov_s r3,0x0
L_8e16ca:
	b.d L_8d9b6c
L_8e16ce:
	mov_s r4,r3
L_8e16d0:
	add_s r0,r0,0xc
L_8e16d2:
	ld_s r1,[r0,0x8]
L_8e16d4:
	ld_s r1,[r1,0x14]
L_8e16d6:
	j_s [r1]
