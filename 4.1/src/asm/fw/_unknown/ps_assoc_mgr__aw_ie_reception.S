/* ps_assoc_mgr__aw_ie_reception @ 0x8c34f4, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ps_assoc_mgr::aw_ie_reception Previous AW Duration: %d. New AW Duration %d
 * Зовут его: ps_assoc_mgr__set_awake_tsf
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit2, mac__mul_886fc4_by_886d64, memcpy_fw, mid__get_awake_window, mid__set_awake_window, mid_list__by_mid
 */
	.section .text.ps_assoc_mgr__aw_ie_reception,"ax",@progbits
	.global ps_assoc_mgr__aw_ie_reception
ps_assoc_mgr__aw_ie_reception:
	.global L_8c34f4
L_8c34f4:
	push_s blink
L_8c34f6:
	bl L_8c02c0
L_8c34fa:
	sub_s sp,sp,0x4
L_8c34fc:
	mov_s r14,r1
L_8c34fe:
	mov_s r13,0x0
L_8c3500:
	bl.d L_8ca1b0
L_8c3504:
	mov_s r0,r13
L_8c3506:
	add3 r15,r0,0x9
L_8c350a:
	breq_s r14,0,L_8c351a
L_8c350c:
	add r0,sp,0x2
L_8c3510:
	mov_s r1,r14
L_8c3512:
	bl.d L_8c0460
L_8c3516:
	mov_s r2,0x2
L_8c3518:
	b_s L_8c351e
	.global L_8c351a
L_8c351a:
	stw r13,[sp, 0x2]
	.global L_8c351e
L_8c351e:
	bl.d L_8c989c
L_8c3522:
	mov_s r0,r15
L_8c3524:
	ldw r4,[sp, 0x2]
L_8c3528:
	mov_s r13,r0
L_8c352a:
	breq r0,r4,L_8c355a
L_8c352e:
	mov_s r2,0x1002620
L_8c3534:
	mov_s r0,0xb
L_8c3536:
	mov_s r1,0x2
L_8c3538:
	bl.d L_8edff8
L_8c353c:
	mov_s r3,r13
L_8c353e:
	ldw r0,[sp, 0x2]
L_8c3542:
	cmp_s r13,r0
L_8c3544:
	mov_s r0,0x0
L_8c3546:
	mov.ls r0,0x4
L_8c354a:
	bl L_8e47b4
L_8c354e:
	mov_s r2,r0
L_8c3550:
	mov_s r0,r15
L_8c3552:
	bl.d L_8e1590
L_8c3556:
	ldw r1,[sp, 0x2]
	.global L_8c355a
L_8c355a:
	b.d L_8c032c
L_8c355e:
	add_s sp,sp,0x4
