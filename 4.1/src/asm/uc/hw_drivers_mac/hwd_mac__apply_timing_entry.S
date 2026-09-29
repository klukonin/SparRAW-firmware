/* hwd_mac__apply_timing_entry @ 0x926dd0, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_mac.c
 * Зовут его: rate_search__apply_mcs
 * Зовёт сам: uc_sysassert
 */
	.section .text.hwd_mac__apply_timing_entry,"ax",@progbits
	.global hwd_mac__apply_timing_entry
hwd_mac__apply_timing_entry:
	.global L_926dd0
L_926dd0:
	st.a r13,[sp,-0x14]
L_926dd4:
	st blink,[sp, 0x4]
L_926dd8:
	st_s r14,[sp,0x8]
L_926dda:
	st_s r15,[sp,0xc]
L_926ddc:
	st r16,[sp, 0x10]
L_926de0:
	mov_s r13,0x800b64
L_926de6:
	add1_s r13,r13,r0
L_926de8:
	ldw r6,[r13]
L_926dec:
	mov r16,0xffff0000
L_926df4:
	tst r6,r16
L_926df8:
	mov r14,r0
L_926dfc:
	bne.d L_926e4c
L_926e00:
	mov r15,r1
	.global L_926e04
L_926e04:
	mov r5,0x887000
L_926e0c:
	ld.as r3,[r5,-0xe4]
L_926e10:
	ldw_s r2,[r13]
L_926e12:
	and r3,r3,r16
L_926e16:
	or_s r2,r2,r3
L_926e18:
	st.as r2,[r5,-0xe4]
L_926e1c:
	ldb r4,[r14,0x800b80]
L_926e24:
	asl_s r1,r15,0x5
L_926e26:
	st.as r4,[r5,-0xe3]
L_926e2a:
	add_s r1,r1,0x4435800
L_926e30:
	lsr_s r1,r1,0x3
L_926e32:
	bic r1,r1,0x3
L_926e36:
	st_s r14,[r1]
L_926e38:
	ld blink,[sp, 0x4]
L_926e3c:
	ld_s r14,[sp,0x8]
L_926e3e:
	ld_s r15,[sp,0xc]
L_926e40:
	ld r16,[sp, 0x10]
L_926e44:
	j.d [blink]
L_926e48:
	ld.ab r13,[sp,0x14]
	.global L_926e4c
L_926e4c:
	mov_s r0,blink
L_926e4e:
	mov_s r2,0x10037c4
L_926e54:
	mov r1,0xac
L_926e58:
	bl.d L_925548
L_926e5c:
	mov r3,0x74
L_926e60:
	b_s L_926e04
L_926e62:
	nop_s
