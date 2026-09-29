/* obj__store3_thunk @ 0x8c17b4, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__install_handler_ptrs
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, obj__store3, obj_vt8005e4__ctor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj__store3_thunk
obj__store3_thunk:
	.global L_8c17b4
L_8c17b4:
	mov_s r1,r2
L_8c17b6:
	mov_s r2,r3
L_8c17b8:
	b.d L_8d8fdc
L_8c17bc:
	mov_s r3,r4
L_8c17be:
	nop_s
	.global L_8c17c0
L_8c17c0:
	push_s blink
L_8c17c2:
	bl L_8c01e4
L_8c17c6:
	mov_s r14,r0
L_8c17c8:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c17ca:
	mov_s r13,0x0
L_8c17cc:
	bl.d L_8c180c
L_8c17d0:
	mov_s r1,r13
L_8c17d2:
	st_s r13,[r14,0x58]
L_8c17d4:
	mov_s r0,r14
L_8c17d6:
	add r0,r0,0x45c
L_8c17da:
	stb_s r13,[r0]
L_8c17dc:
	stb_s r13,[r0,0x1]
L_8c17de:
	mov_s r0,0x1
L_8c17e0:
	add r14,r14,0x400
L_8c17e4:
	stb r0,[r14, 0x5e]
L_8c17e8:
	st_s r0,[r14,0x60]
L_8c17ea:
	stb r13,[r14, 0x64]
L_8c17ee:
	stw r0,[r14, 0x66]
L_8c17f2:
	st_s r13,[r14,0x68]
L_8c17f4:
	st_s r13,[r14,0x6c]
L_8c17f6:
	stb r13,[r14, 0x70]
L_8c17fa:
	mov_s r1,0x84783c
L_8c1800:
	mov_s r0,0x857780
L_8c1806:
	b.d L_8c0254
L_8c180a:
	st_s r1,[r0,0x30]
