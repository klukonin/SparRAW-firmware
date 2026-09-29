/* calib_mngr__engine_step @ 0x8e79c0, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__on_calib_done, calib_engine__run_requested, calib_mngr__engine_start
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, basic_sm__handle_event, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_mngr__engine_step
calib_mngr__engine_step:
	.global L_8e79c0
L_8e79c0:
	sub_s sp,sp,0x4
L_8e79c2:
	push_s blink
L_8e79c4:
	bl L_8c01cc
L_8e79c8:
	mov_s r16,r1
L_8e79ca:
	mov_s r13,r0
L_8e79cc:
	mov_s r14,r2
L_8e79ce:
	mov_s r15,r3
L_8e79d0:
	mov r20,r4
L_8e79d4:
	ldb_s r0,[r0]
L_8e79d6:
	mov r18,r6
L_8e79da:
	mov r17,r5
L_8e79de:
	mov r19,r7
L_8e79e2:
	brne_s r0,0,L_8e7a22
	.global L_8e79e4
L_8e79e4:
	brne_s r14,0,L_8e79ea
L_8e79e6:
	brne r15,0x1,L_8e7a2e
	.global L_8e79ea
L_8e79ea:
	st r16,[r13, 0x10]
L_8e79ee:
	st_s r14,[r13,0x14]
L_8e79f0:
	st_s r15,[r13,0x1c]
L_8e79f2:
	stw r20,[r13, 0x20]
L_8e79f6:
	st r17,[r13, 0x2c]
L_8e79fa:
	st r18,[r13, 0x30]
L_8e79fe:
	st r19,[r13, 0x34]
L_8e7a02:
	mov_s r1,0x0
L_8e7a04:
	st_s r1,[r13,0x18]
L_8e7a06:
	st_s r1,[r13,0x38]
L_8e7a08:
	stb r1,[r13, 0x3c]
L_8e7a0c:
	st_s r1,[r13,0x28]
L_8e7a0e:
	st_s r1,[r13,0x24]
L_8e7a10:
	mov_s r0,r13
L_8e7a12:
	mov_s r2,r1
L_8e7a14:
	mov_s r3,r1
L_8e7a16:
	bl.d L_8d9b6c
L_8e7a1a:
	mov_s r4,r1
L_8e7a1c:
	mov_s r12,0x8
L_8e7a1e:
	b L_8c0226
	.global L_8e7a22
L_8e7a22:
	mov_s r0,blink
L_8e7a24:
	mov_s r1,0x87
L_8e7a26:
	bl.d L_8c9b28
L_8e7a2a:
	bset_s r1,r1,0xc
L_8e7a2c:
	b_s L_8e79e4
	.global L_8e7a2e
L_8e7a2e:
	mov_s r0,blink
L_8e7a30:
	mov_s r1,0x25
L_8e7a32:
	/* bl.d 0x008c9b28 */
	.byte 0xfa,0x08,0x2f,0xf1
L_8e7a36:
	/* _asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_8e7a38:
	b_s L_8e79ea
L_8e7a3a:
	nop_s
