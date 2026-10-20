/* stream_mgr__check_count_a @ 0x8c8774, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__2
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, stream__inject_evt1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__check_count_a
stream_mgr__check_count_a:
	.global L_8c8774
L_8c8774:
	push_s blink
L_8c8776:
	push_s r13
L_8c8778:
	mov_s r13,r0
L_8c877a:
	ldb_s r0,[r0,0xa]
L_8c877c:
	brlt r0,0x1,L_8c8796
	.global L_8c8780
L_8c8780:
	ldb_s r0,[r13,0xa]
L_8c8782:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8c8784:
	extb.f r0,r0
L_8c8788:
	stb_s r0,[r13,0xa]
L_8c878a:
	bl.eq.d L_8e8354
L_8c878e:
	mov.eq r0,r13
L_8c8792:
	b L_8c025c
	.global L_8c8796
L_8c8796:
	mov_s r0,blink
L_8c8798:
	mov_s r1,0x47
L_8c879a:
	/* bl.d 0x008c9b28 */
	.byte 0x92,0x0b,0xa0,0x00
L_8c879e:
	/* _asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8c87a0:
	b_s L_8c8780
L_8c87a2:
	nop_s
