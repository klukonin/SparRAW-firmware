/* sm_801d64__action_8e175c @ 0x8e175c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, brd_if_multi_array__get_block_info, ps_conn__profile_params_by_index, psc_if__start_psc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_801d64__action_8e175c
sm_801d64__action_8e175c:
	.global L_8e175c
L_8e175c:
	push_s blink
L_8e175e:
	push_s r13
L_8e1760:
	sub_s sp,sp,0xc
L_8e1762:
	mov_s r13,r0
L_8e1764:
	mov_s r1,sp
L_8e1766:
	bl.d L_8ccc7c
L_8e176a:
	ldw_s r0,[r0,0xc]
L_8e176c:
	mov_s r0,r13
L_8e176e:
	bl.d L_8cb940
L_8e1772:
	mov_s r1,0x1
L_8e1774:
	mov_s r2,r0
L_8e1776:
	ldb r0,[sp, 0x1]
L_8e177a:
	mov_s r1,0x1
L_8e177c:
	stw r0,[sp, 0x8]
L_8e1780:
	ldb_s r0,[sp,0x0]
L_8e1782:
	stw r0,[sp, 0xa]
L_8e1786:
	ld_s r0,[r13,0x8]
L_8e1788:
	bl.d L_8d9cc8
L_8e178c:
	ld_s r3,[sp,0x8]
L_8e178e:
	b.d L_8c025c
L_8e1792:
	add_s sp,sp,0xc
