/* ring__init_desc @ 0x8d5898, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__build_cmd_rings, mbox__build_rings_and_pool
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ring__fill_from_pool
 */
	.section .text.ring__init_desc,"ax",@progbits
	.global ring__init_desc
ring__init_desc:
	.global L_8d5898
L_8d5898:
	push_s blink
L_8d589a:
	bl L_8c02c0
L_8d589e:
	mov_s r14,r5
L_8d58a0:
	st_s r1,[r0]
L_8d58a2:
	st_s r1,[r0,0x4]
L_8d58a4:
	add_s r1,r1,r2
L_8d58a6:
	st_s r1,[r0,0x8]
L_8d58a8:
	st_s r3,[r0,0xc]
L_8d58aa:
	st r4,[r0, 0x10]
L_8d58ae:
	mov_s r1,0x0
L_8d58b0:
	st_s r1,[r0,0x18]
L_8d58b2:
	st_s r1,[r0,0x1c]
L_8d58b4:
	cmp r6,0x1
L_8d58b8:
	st r6,[r0, 0x14]
L_8d58bc:
	bl.eq.d L_8dca80
L_8d58c0:
	mov.eq r1,r14
L_8d58c4:
	b L_8c032c
