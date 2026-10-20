/* xpm_read_cnt @ 0x8f39d0, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   xpm_read_cnt FAILED
 *   marlon_r_if.cpp
 * Зовут его: otp__read_bytes, otp__read_counters
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit0, fw_sysassert_fatal, hwd_rfc__read_xpm_with_delay
 */
	.section .text.xpm_read_cnt,"ax",@progbits
	.global xpm_read_cnt
xpm_read_cnt:
	.global L_8f39d0
L_8f39d0:
	push_s blink
L_8f39d2:
	bl L_8c02bc
L_8f39d6:
	sub_s sp,sp,0x4
L_8f39d8:
	and r0,r2,0xffff0000
L_8f39e0:
	cmp_s r0,0x0
L_8f39e2:
	mov_s r0,0x1
L_8f39e4:
	sub_s.ne r0,r0,r0
L_8f39e6:
	mov_s r16,r2
L_8f39e8:
	ld.as r13,[gp,-0x36]
L_8f39ec:
	brne r0,0x1,L_8f3a22
	.global L_8f39f0
L_8f39f0:
	mov_s r2,sp
L_8f39f2:
	mov_s r0,0x0
L_8f39f4:
	bl.d L_8d06b0
L_8f39f8:
	mov_s r1,r16
L_8f39fa:
	brne_s r0,0,L_8f3a38
L_8f39fc:
	mov_s r2,0x10052f8
L_8f3a02:
	mov_s r0,0x0
L_8f3a04:
	bl.d L_8edfb0
L_8f3a08:
	mov_s r1,0x2
L_8f3a0a:
	sub.f r13,r13,0x1
L_8f3a0e:
	bne_s L_8f39f0
L_8f3a10:
	mov_s r0,blink
L_8f3a12:
	mov_s r2,0x1005078
L_8f3a18:
	mov_s r1,0x55
L_8f3a1a:
	bset_s r1,r1,0xc
L_8f3a1c:
	mov r3,0x165
L_8f3a20:
	b_s L_8f3a32
	.global L_8f3a22
L_8f3a22:
	mov_s r0,blink
L_8f3a24:
	mov_s r2,0x1005078
L_8f3a2a:
	mov_s r1,0x54
L_8f3a2c:
	bset_s r1,r1,0xc
L_8f3a2e:
	mov r3,0x154
	.global L_8f3a32
L_8f3a32:
	bl L_8c82c0
L_8f3a36:
	b_s L_8f39f0
	.global L_8f3a38
L_8f3a38:
	ldb_s r0,[sp,0x0]
L_8f3a3a:
	b.d L_8c0324
L_8f3a3e:
	add_s sp,sp,0x4
