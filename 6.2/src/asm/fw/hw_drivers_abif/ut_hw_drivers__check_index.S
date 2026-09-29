/* ut_hw_drivers__check_index @ 0x8cfc0c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MCS %d is out of range, should be <=%d
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_drivers__check_index
ut_hw_drivers__check_index:
	.global L_8cfc0c
L_8cfc0c:
	push_s blink
L_8cfc0e:
	bl L_8c01e0
L_8cfc12:
	mov_s r14,r0
L_8cfc14:
	brge.d r0,0xd,L_8cfc54
L_8cfc18:
	mov_s r13,r1
	.global L_8cfc1a
L_8cfc1a:
	bic.f 0x0,r13,0x1f
L_8cfc1e:
	bne_s L_8cfc74
	.global L_8cfc20
L_8cfc20:
	asl_s r0,r14,0x5
L_8cfc22:
	add_s r0,r0,0x4448da0
L_8cfc28:
	lsr r1,r0,0x3
L_8cfc2c:
	bic r2,r1,0x3
L_8cfc30:
	ld_s r1,[r2]
L_8cfc32:
	bmsk_s r0,r0,0x4
L_8cfc34:
	add_s r14,r0,0x4
L_8cfc36:
	mov_s r3,0x0
L_8cfc38:
	bset r3,r3,r14
L_8cfc3c:
	mov_s r15,0x0
L_8cfc3e:
	bset r15,r15,r0
L_8cfc42:
	sub r14,r3,r15
L_8cfc46:
	or_s r3,r3,r14
L_8cfc48:
	bic_s r1,r1,r3
L_8cfc4a:
	asl_s r13,r13,r0
L_8cfc4c:
	or_s r13,r13,r1
L_8cfc4e:
	st_s r13,[r2]
L_8cfc50:
	b L_8c024c
	.global L_8cfc54
L_8cfc54:
	mov_s r1,0x101f0ac
L_8cfc5a:
	mov_s r0,0x0
L_8cfc5c:
	mov_s r2,r14
L_8cfc5e:
	mov_s r3,0xc
L_8cfc60:
	bl.d L_8dcd00
L_8cfc64:
	mov_s r4,r0
L_8cfc66:
	mov_s r0,blink
L_8cfc68:
	mov_s r1,0x1450
L_8cfc6e:
	bl L_8c9b28
L_8cfc72:
	b_s L_8cfc1a
	.global L_8cfc74
L_8cfc74:
	mov_s r0,blink
L_8cfc76:
	bl.d L_8c9b28
L_8cfc7a:
	mov_s r1,0xac
L_8cfc7c:
	b_s L_8cfc20
L_8cfc7e:
	nop_s
