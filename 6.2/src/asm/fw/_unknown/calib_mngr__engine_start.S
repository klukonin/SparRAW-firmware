/* calib_mngr__engine_start @ 0x8ca25c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Engine of %s is already active
 * Зовут его: calib__start_scheme4, calib_mgr_ut
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, calib_mngr__engine_step, fw_log__emit1_tsf, platform__is_asic
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_mngr__engine_start
calib_mngr__engine_start:
	.global L_8ca25c
L_8ca25c:
	sub_s sp,sp,0x4
L_8ca25e:
	push_s blink
L_8ca260:
	bl L_8c01cc
L_8ca264:
	mov_s r15,r1
L_8ca266:
	mov_s r13,r0
L_8ca268:
	mov_s r20,r2
L_8ca26a:
	mov_s r19,r3
L_8ca26c:
	mov r18,r4
L_8ca270:
	mov r17,r5
L_8ca274:
	mov r16,r6
L_8ca278:
	bl.d L_8da61c
L_8ca27c:
	mov_s r14,r7
L_8ca27e:
	breq_s r0,0,L_8ca2ca
L_8ca280:
	mul64 r13,0x44
L_8ca284:
	add r0,mlo,0x804944
L_8ca28c:
	ldb_s r1,[r0]
L_8ca28e:
	cmp_s r1,0x0
L_8ca290:
	mov_s r1,0x1
L_8ca292:
	sub_s.ne r1,r1,r1
L_8ca294:
	extb.f 0x0,r1
L_8ca298:
	beq_s L_8ca2b4
L_8ca29a:
	mov_s r1,r15
L_8ca29c:
	mov_s r2,r20
L_8ca29e:
	mov_s r3,r19
L_8ca2a0:
	mov r4,r18
L_8ca2a4:
	mov r5,r17
L_8ca2a8:
	mov r6,r16
L_8ca2ac:
	bl.d L_8e79c0
L_8ca2b0:
	mov_s r7,r14
L_8ca2b2:
	b_s L_8ca2ca
	.global L_8ca2b4
L_8ca2b4:
	mov_s r0,0x800dc8
L_8ca2ba:
	ld.as r2,[r0,r13]
L_8ca2be:
	mov_s r1,0x1009364
L_8ca2c4:
	bl.d L_8dcd90
L_8ca2c8:
	mov_s r0,0x26
	.global L_8ca2ca
L_8ca2ca:
	mov_s r12,0x8
L_8ca2cc:
	b L_8c0226
