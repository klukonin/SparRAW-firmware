/* vring_schd__fill_vring_cfg @ 0x8e267c, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schdlr.cpp
 * Зовут его: vring_schd__add_vring
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_sysassert_fatal, vring__disable_and_ack, vring__get_pring_id
 */
	.section .text.vring_schd__fill_vring_cfg,"ax",@progbits
	.global vring_schd__fill_vring_cfg
vring_schd__fill_vring_cfg:
	.global L_8e267c
L_8e267c:
	push_s blink
L_8e267e:
	bl L_8c02b4
L_8e2682:
	mov_s r14,r0
L_8e2684:
	mov_s r13,r1
L_8e2686:
	mov_s r16,r2
L_8e2688:
	mov_s r15,r3
L_8e268a:
	mov r17,r4
L_8e268e:
	mov r18,r5
L_8e2692:
	brne r5,0x1,L_8e269c
L_8e2696:
	breq_s r15,0,L_8e26cc
	.global L_8e2698
L_8e2698:
	ld_s r0,[r14,0x24]
L_8e269a:
	brne_s r0,0,L_8e26e2
	.global L_8e269c
L_8e269c:
	ldb_s r0,[r13,0x6]
L_8e269e:
	stb_s r0,[r14,0x8]
L_8e26a0:
	ldb_s r0,[r13,0x7]
L_8e26a2:
	stb_s r0,[r14,0x9]
L_8e26a4:
	bl.d L_8c9d94
L_8e26a8:
	mov_s r0,r13
L_8e26aa:
	stb_s r0,[r14,0xa]
L_8e26ac:
	stb r16,[r14, 0xb]
L_8e26b0:
	stw_s r15,[r14,0xc]
L_8e26b2:
	st r17,[r14, 0x10]
L_8e26b6:
	mov_s r0,0x0
L_8e26b8:
	st_s r0,[r14,0x14]
L_8e26ba:
	st_s r0,[r14,0x18]
L_8e26bc:
	st_s r0,[r14,0x1c]
L_8e26be:
	st r18,[r14, 0x20]
L_8e26c2:
	bl.d L_8d5244
L_8e26c6:
	mov_s r0,r14
L_8e26c8:
	b L_8c0314
	.global L_8e26cc
L_8e26cc:
	mov_s r0,blink
L_8e26ce:
	mov_s r2,0x100a584
L_8e26d4:
	mov_s r1,0x12b2
L_8e26da:
	bl.d L_8c82c0
L_8e26de:
	mov_s r3,0x6f
L_8e26e0:
	b_s L_8e2698
	.global L_8e26e2
L_8e26e2:
	mov_s r0,blink
L_8e26e4:
	mov_s r2,0x100a584
L_8e26ea:
	mov_s r1,0x12b3
L_8e26f0:
	bl.d L_8c82c0
L_8e26f4:
	mov_s r3,0x70
L_8e26f6:
	b_s L_8e269c
