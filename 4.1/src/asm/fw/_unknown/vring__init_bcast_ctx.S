/* vring__init_bcast_ctx @ 0x8d6638, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__setup_bcast_vring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ba_sm__init
 */
	.section .text.vring__init_bcast_ctx,"ax",@progbits
	.global vring__init_bcast_ctx
vring__init_bcast_ctx:
	.global L_8d6638
L_8d6638:
	push_s blink
L_8d663a:
	bl L_8c02c0
L_8d663e:
	mov_s r13,r0
L_8d6640:
	st_s r2,[r0]
L_8d6642:
	stb_s r3,[r0,0x4]
L_8d6644:
	st r4,[r0, 0xc0]
L_8d6648:
	mov_s r0,0x0
L_8d664a:
	st r0,[r13, 0xc4]
L_8d664e:
	stw r0,[r13, 0xc8]
L_8d6652:
	stb r5,[r13, 0x5]
L_8d6656:
	stb r6,[r13, 0x6]
L_8d665a:
	stb_s r1,[r13,0x7]
L_8d665c:
	ld_s r0,[sp,0x10]
L_8d665e:
	st r7,[r13, 0x8]
L_8d6662:
	st_s r0,[r13,0xc]
L_8d6664:
	add r0,r13,0x10
L_8d6668:
	bl.d L_8d61f0
L_8d666c:
	mov_s r1,r13
L_8d666e:
	b L_8c032c
L_8d6672:
	nop_s
