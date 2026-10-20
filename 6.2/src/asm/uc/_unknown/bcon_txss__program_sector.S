/* bcon_txss__program_sector @ 0x934ff0, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_txss_sweep_step
 * Зовёт сам: mac_evt__select_timer_group
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bcon_txss__program_sector
bcon_txss__program_sector:
	.global L_934ff0
L_934ff0:
	st.a r13,[sp,-0x10]
L_934ff4:
	st blink,[sp, 0x4]
L_934ff8:
	st_s r14,[sp,0x8]
L_934ffa:
	st_s r15,[sp,0xc]
L_934ffc:
	mov_s r14,r0
L_934ffe:
	mov_s r13,r1
L_935000:
	bl.d L_9258e0
L_935004:
	mov r15,r2
L_935008:
	asl r0,r14,0x14
L_93500c:
	and r0,r0,0xf00000
L_935014:
	or r0,r0,0x68000000
L_93501c:
	mov r32,r0
L_935020:
	st.ab r0,[r25,0x4]
L_935024:
	bclr r25,r25,0xa
L_935028:
	nop_s
L_93502a:
	nop_s
L_93502c:
	nop_s
L_93502e:
	or r13,r13,0x67000000
L_935036:
	mov_s r32,r13
L_935038:
	st.ab r13,[r25,0x4]
L_93503c:
	bclr r25,r25,0xa
L_935040:
	nop_s
L_935042:
	nop_s
L_935044:
	nop_s
L_935046:
	asl r1,r15,0x8
L_93504a:
	and r1,r1,0x1f00
L_935052:
	or r2,r1,0x6800000e
L_93505a:
	asl_s r14,r14,0x14
L_93505c:
	and r1,r14,0xf00000
L_935064:
	or_s r1,r1,r2
L_935066:
	mov_s r32,r1
L_935068:
	st.ab r1,[r25,0x4]
L_93506c:
	bclr r25,r25,0xa
L_935070:
	ld blink,[sp, 0x4]
L_935074:
	ld_s r14,[sp,0x8]
L_935076:
	ld_s r15,[sp,0xc]
L_935078:
	j.d [blink]
L_93507c:
	ld.ab r13,[sp,0x10]
