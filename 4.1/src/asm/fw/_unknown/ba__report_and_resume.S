/* ba__report_and_resume @ 0x8c3808, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, l2mgr__send_ba_status_evt, vring_schd__resume_vring
 */
	.section .text.ba__report_and_resume,"ax",@progbits
	.global ba__report_and_resume
ba__report_and_resume:
L_8c3808:
	add_s sp,sp,0x10
	.global sub_8c380a
sub_8c380a:
L_8c380a:
	nop_s
L_8c380c:
	push_s blink
L_8c380e:
	push_s r13
L_8c3810:
	mov_s r13,r0
L_8c3812:
	ld_s r0,[r0,0xc]
L_8c3814:
	brne_s r0,0,L_8c3832
L_8c3816:
	ld r1,[r13, 0xc4]
L_8c381a:
	cmp_s r1,0x0
L_8c381c:
	ldb_s r0,[r13,0x7]
L_8c381e:
	bl.eq L_8de858
L_8c3822:
	mov_s r0,r13
L_8c3824:
	ldb_s r1,[r13,0x7]
L_8c3826:
	mov_s r2,0x1
L_8c3828:
	mov_s r3,0x0
L_8c382a:
	mov_s r4,r3
L_8c382c:
	bl.d L_8e061c
L_8c3830:
	mov_s r5,r3
	.global L_8c3832
L_8c3832:
	.byte 0x0d,0x03
