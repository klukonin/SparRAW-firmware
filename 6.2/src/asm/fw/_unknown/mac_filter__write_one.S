/* mac_filter__write_one @ 0x8df704, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: install_key__parse_flags, stream_mgr__prepare_1f
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bits__set16h_s0_w2, fw_sysassert_fatal, mac_filter__bits_set16h_s4_w2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_filter__write_one
mac_filter__write_one:
	.global L_8df704
L_8df704:
	push_s blink
L_8df706:
	bl L_8c01e0
L_8df70a:
	sub_s sp,sp,0x4
L_8df70c:
	mov_s r14,r0
L_8df70e:
	mov_s r15,r1
L_8df710:
	brhs.d r2,0x8,L_8df76a
L_8df714:
	mov_s r13,r2
	.global L_8df716
L_8df716:
	mov_s r0,0x0
L_8df718:
	stw r0,[sp, 0x2]
L_8df71c:
	add r0,sp,0x2
L_8df720:
	mov_s r1,0x1
L_8df722:
	bl.d L_8ed2d4
L_8df726:
	add3_s r13,r13,r15
L_8df728:
	mov_s r1,0x2
L_8df72a:
	bl L_8ed304
L_8df72e:
	ldw r0,[sp, 0x2]
L_8df732:
	mov_s r2,0x886000
L_8df738:
	asl_s r0,r0,0x10
L_8df73a:
	bset_s r0,r0,0x1f
L_8df73c:
	mov_s r1,0x886200
L_8df742:
	st_s r0,[r1,0x78]
L_8df744:
	st_s r13,[r1,0x7c]
L_8df746:
	ld_s r0,[r14]
L_8df748:
	st.as r0,[r2,0xa0]
L_8df74c:
	st 0x40000000,[r1, 0x74]
L_8df754:
	sync
	.global L_8df758
L_8df758:
	mov_s r0,0x886200
L_8df75e:
	ld_s r0,[r0,0x74]
L_8df760:
	bbit1 r0,0x1d,L_8df758
L_8df764:
	b.d L_8c024c
L_8df768:
	add_s sp,sp,0x4
	.global L_8df76a
L_8df76a:
	mov_s r0,blink
L_8df76c:
	mov_s r1,0x12
L_8df76e:
	bl.d L_8c9b28
L_8df772:
	bset_s r1,r1,0xc
L_8df774:
	b_s L_8df716
L_8df776:
	nop_s
