/* sector_mem__addr_of @ 0x922e14, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_restore_sectors, rfca__access_sector_other_rf
 * Зовёт сам: __ld_r13_to_r13_ret, brp__write_reg_pair
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sector_mem__addr_of
sector_mem__addr_of:
	.global L_922e14
L_922e14:
	push_s blink
L_922e16:
	push_s r13
L_922e18:
	add_s r0,r0,0x60
L_922e1a:
	extb_s r0,r0
L_922e1c:
	asl_s r13,r0,0x6
L_922e1e:
	add1_s r13,r13,r13
L_922e20:
	add r0,r13,0x10060
L_922e28:
	lsr_s r0,r0,0x3
L_922e2a:
	bic r0,r0,0x3
L_922e2e:
	bl.d L_92f9d8
L_922e32:
	mov_s r1,0x0
L_922e34:
	add r0,r13,0x10040
L_922e3c:
	lsr_s r0,r0,0x3
L_922e3e:
	bic r0,r0,0x3
L_922e42:
	bl.d L_92f9d8
L_922e46:
	mov_s r1,0x0
L_922e48:
	add r0,r13,0x100a0
L_922e50:
	lsr_s r0,r0,0x3
L_922e52:
	bic r0,r0,0x3
L_922e56:
	bl.d L_92f9d8
L_922e5a:
	mov_s r1,0x0
L_922e5c:
	add r0,r13,0x10080
L_922e64:
	lsr_s r0,r0,0x3
L_922e66:
	bic r0,r0,0x3
L_922e6a:
	bl.d L_92f9d8
L_922e6e:
	mov_s r1,0x0
L_922e70:
	b L_9202ac
