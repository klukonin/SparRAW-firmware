/* sm_obj__store_desc @ 0x8d96c0, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__configure_tx
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, obj_vt80296c__ctor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_obj__store_desc
sm_obj__store_desc:
	.global L_8d96c0
L_8d96c0:
	push_s blink
L_8d96c2:
	bl L_8c01e0
L_8d96c6:
	mov_s r13,r0
L_8d96c8:
	st_s r2,[r0]
L_8d96ca:
	stb_s r3,[r0,0x4]
L_8d96cc:
	st r4,[r0, 0x54]
L_8d96d0:
	mov_s r2,0x0
L_8d96d2:
	st_s r2,[r0,0x58]
L_8d96d4:
	stw r2,[r0, 0x5c]
L_8d96d8:
	stb r5,[r0, 0x5]
L_8d96dc:
	stb r6,[r0, 0x6]
L_8d96e0:
	stb_s r1,[r0,0x7]
L_8d96e2:
	st r7,[r0, 0x8]
L_8d96e6:
	ld_s r0,[sp,0x10]
L_8d96e8:
	stb r2,[r13, 0x5e]
L_8d96ec:
	st_s r0,[r13,0xc]
L_8d96ee:
	add r0,r13,0x10
L_8d96f2:
	bl.d L_8d9230
L_8d96f6:
	mov_s r1,r13
L_8d96f8:
	b L_8c024c
