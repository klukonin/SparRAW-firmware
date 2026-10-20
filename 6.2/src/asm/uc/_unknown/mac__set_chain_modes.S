/* mac__set_chain_modes @ 0x9369e0, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_tx__check_idle_and_start_uc, fixed_sched__run_tx_slot
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__set_chain_modes
mac__set_chain_modes:
	.global L_9369e0
L_9369e0:
	push_s blink
L_9369e2:
	bl L_920234
L_9369e6:
	mov_s r13,r0
L_9369e8:
	ld_s r0,[gp,-0x44]
L_9369ea:
	and r0,r0,0xffff0fff
L_9369f2:
	st.as r0,[gp,-0x11]
L_9369f6:
	or r0,r0,0x1d000000
L_9369fe:
	mov_s r32,r0
L_936a00:
	st.ab r0,[r25,0x4]
L_936a04:
	bclr r25,r25,0xa
L_936a08:
	nop_s
L_936a0a:
	nop_s
L_936a0c:
	nop_s
L_936a0e:
	lsr r0,r40,0x10
L_936a12:
	bmsk_s r0,r0,0x3
L_936a14:
	cmp_s r0,0x2
L_936a16:
	mov_s r1,0x1
L_936a18:
	sub.hi r1,r1,r1
L_936a1c:
	lsr r0,r40,0x14
L_936a20:
	bmsk_s r0,r0,0x3
L_936a22:
	cmp_s r0,0x2
L_936a24:
	mov_s r2,0x1
L_936a26:
	sub.hi r2,r2,r2
L_936a2a:
	lsr r0,r40,0x18
L_936a2e:
	bmsk_s r0,r0,0x3
L_936a30:
	cmp_s r0,0x2
L_936a32:
	mov_s r3,0x1
L_936a34:
	sub.hi r3,r3,r3
L_936a38:
	lsr r0,r40,0x1c
L_936a3c:
	cmp_s r0,0x2
L_936a3e:
	mov_s r0,0x1
L_936a40:
	sub.hi r0,r0,r0
L_936a44:
	cmp_s r1,0x0
L_936a46:
	mov.ne r14,r13
L_936a4a:
	mov.eq r14,0x0
L_936a4e:
	cmp_s r2,0x0
L_936a50:
	mov.ne r1,r13
L_936a54:
	mov.eq r1,0x0
L_936a58:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_936a5a:
	bset_s r14,r14,0x1b
L_936a5c:
	or_s r14,r14,r1
L_936a5e:
	cmp_s r3,0x0
L_936a60:
	mov.ne r1,r13
L_936a64:
	mov.eq r1,0x0
L_936a68:
	cmp_s r0,0x0
L_936a6a:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_936a6c:
	mov.eq r13,0x0
L_936a70:
	or_s r1,r1,r14
L_936a72:
	/* asl_s r13,r13,0x6 */
	.byte 0x06,0xbd
L_936a74:
	or_s r13,r13,r1
L_936a76:
	ld_s r0,[gp,-0xd4]
L_936a78:
	mov_s r1,0x80146c
L_936a7e:
	ld_s r1,[r1,0x8]
L_936a80:
	and_s r0,r0,r1
L_936a82:
	or_s r0,r0,r13
L_936a84:
	mov_s r32,r0
L_936a86:
	st.ab r0,[r25,0x4]
L_936a8a:
	bclr r25,r25,0xa
L_936a8e:
	b L_9202a4
L_936a92:
	nop_s
