/* calib_engine__post_event @ 0x8e27a4, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_engine.cpp
 * Зовут его: calib_engine__start_step, calib_mngr__engine_start, calib_mngr__reset_scheme
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, basic_sm__inject_event, fw_sysassert_fatal
 */
	.section .text.calib_engine__post_event,"ax",@progbits
	.global calib_engine__post_event
calib_engine__post_event:
	.global L_8e27a4
L_8e27a4:
	sub_s sp,sp,0x4
L_8e27a6:
	push_s blink
L_8e27a8:
	bl L_8c02ac
L_8e27ac:
	mov_s r16,r1
L_8e27ae:
	mov_s r13,r0
L_8e27b0:
	mov_s r14,r2
L_8e27b2:
	mov_s r15,r3
L_8e27b4:
	mov r20,r4
L_8e27b8:
	ldb_s r0,[r0]
L_8e27ba:
	mov r18,r6
L_8e27be:
	mov r17,r5
L_8e27c2:
	mov r19,r7
L_8e27c6:
	brne_s r0,0,L_8e2802
	.global L_8e27c8
L_8e27c8:
	brne_s r14,0,L_8e27ce
L_8e27ca:
	brne r15,0x1,L_8e2816
	.global L_8e27ce
L_8e27ce:
	st r16,[r13, 0x34]
L_8e27d2:
	st_s r14,[r13,0x38]
L_8e27d4:
	st_s r15,[r13,0x40]
L_8e27d6:
	stw r20,[r13, 0x44]
L_8e27da:
	st r17,[r13, 0x50]
L_8e27de:
	st r18,[r13, 0x54]
L_8e27e2:
	st r19,[r13, 0x58]
L_8e27e6:
	mov_s r1,0x0
L_8e27e8:
	st_s r1,[r13,0x3c]
L_8e27ea:
	st_s r1,[r13,0x5c]
L_8e27ec:
	st_s r1,[r13,0x4c]
L_8e27ee:
	st_s r1,[r13,0x48]
L_8e27f0:
	mov_s r0,r13
L_8e27f2:
	mov_s r2,r1
L_8e27f4:
	mov_s r3,r1
L_8e27f6:
	bl.d L_8d6a1c
L_8e27fa:
	mov_s r4,r1
L_8e27fc:
	mov_s r12,0x8
L_8e27fe:
	b L_8c0306
	.global L_8e2802
L_8e2802:
	mov_s r0,blink
L_8e2804:
	mov_s r2,0x1008a58
L_8e280a:
	mov_s r1,0x87
L_8e280c:
	bset_s r1,r1,0xc
L_8e280e:
	bl.d L_8c82c0
L_8e2812:
	mov_s r3,0x81
L_8e2814:
	b_s L_8e27c8
	.global L_8e2816
L_8e2816:
	mov_s r0,blink
L_8e2818:
	mov_s r2,0x1008a58
L_8e281e:
	mov_s r1,0x25
L_8e2820:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_8e2822:
	bl.d L_8c82c0
L_8e2826:
	mov_s r3,0x86
