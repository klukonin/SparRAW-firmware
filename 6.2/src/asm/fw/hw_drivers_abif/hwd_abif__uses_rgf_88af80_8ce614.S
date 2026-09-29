/* hwd_abif__uses_rgf_88af80_8ce614 @ 0x8ce614, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib__acquire_hw
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__uses_rgf_88af80_8ce614
hwd_abif__uses_rgf_88af80_8ce614:
	.global L_8ce614
L_8ce614:
	push_s blink
L_8ce616:
	push_s r13
L_8ce618:
	mov_s r0,0x88af80
L_8ce61e:
	ld_s r13,[r0,0x70]
L_8ce620:
	bmsk_s r13,r13,0x4
L_8ce622:
	sub_s r1,r13,0x1
L_8ce624:
	brhs r1,0x10,L_8ce638
L_8ce628:
	ldb.x r1,[0x803934,r1]
L_8ce630:
	add r0,pcl,0x8
L_8ce634:
	add1_s r0,r0,r1
L_8ce636:
	j_s [r0]
	.global L_8ce638
L_8ce638:
	mov_s r0,blink
L_8ce63a:
	mov_s r1,0xad
L_8ce63c:
	bl.d L_8c9b28
L_8ce640:
	bset_s r1,r1,0xc
L_8ce642:
	b.d L_8c025c
L_8ce646:
	mov_s r0,r13
