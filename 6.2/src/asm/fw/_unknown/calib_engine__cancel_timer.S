/* calib_engine__cancel_timer @ 0x8c68ec, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__abort_all
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, u_schd__cancel, vring__find_busy_index
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_engine__cancel_timer
calib_engine__cancel_timer:
	.global L_8c68ec
L_8c68ec:
	push_s blink
L_8c68ee:
	bl L_8c01e0
L_8c68f2:
	brhs.d r0,0x6,L_8c6914
L_8c68f6:
	mov_s r13,r0
	.global L_8c68f8
L_8c68f8:
	mov_s r15,0x804924
L_8c68fe:
	add_s r12,r15,r13
L_8c6900:
	add2_s r15,r15,r13
L_8c6902:
	ld_s r0,[r15,0x8]
L_8c6904:
	mov_s r14,0x0
L_8c6906:
	stb_s r14,[r12]
L_8c6908:
	breq_s r0,0,L_8c6910
L_8c690a:
	bl L_8c8de0
L_8c690e:
	st_s r14,[r15,0x8]
	.global L_8c6910
L_8c6910:
	b L_8c024c
	.global L_8c6914
L_8c6914:
	mov_s r0,blink
L_8c6916:
	mov_s r1,0x1214
L_8c691c:
	bl L_8c9b28
L_8c6920:
	b_s L_8c68f8
L_8c6922:
	nop_s
L_8c6924:
	push_s blink
L_8c6926:
	push_s r13
L_8c6928:
	bl.d L_8ccfe4
L_8c692c:
	mov_s r0,r1
L_8c692e:
	mov_s r13,0x0
L_8c6930:
	breq_s r0,0,L_8c6934
L_8c6932:
	st_s r13,[r0,0x1c]
	.global L_8c6934
L_8c6934:
	b L_8c025c
L_8c6938:
	mov_s r2,0x0
L_8c693a:
	mov_s r0,0x857748
L_8c6940:
	add2_s r0,r0,r1
L_8c6942:
	j_s.d [blink]
L_8c6944:
	st_s r2,[r0]
L_8c6946:
	nop_s
