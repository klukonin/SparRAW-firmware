/* bi_tx__program_initiator @ 0x931aec, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_tx__check_idle_and_start, bi_tx_initiator_wrap
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc
 */
	.section .text.bi_tx__program_initiator,"ax",@progbits
	.global bi_tx__program_initiator
bi_tx__program_initiator:
	.global L_931aec
L_931aec:
	push_s blink
L_931aee:
	bl L_920214
L_931af2:
	mov_s r13,r0
L_931af4:
	ld_s r0,[gp,-0x44]
L_931af6:
	and r0,r0,0xffff0fff
L_931afe:
	st.as r0,[gp,-0x11]
L_931b02:
	or r0,r0,0x1d000000
L_931b0a:
	mov_s r32,r0
L_931b0c:
	st.ab r0,[r25,0x4]
L_931b10:
	bclr r25,r25,0xa
L_931b14:
	nop_s
L_931b16:
	nop_s
L_931b18:
	nop_s
L_931b1a:
	lsr r0,r40,0x10
L_931b1e:
	bmsk_s r0,r0,0x3
L_931b20:
	cmp_s r0,0x2
L_931b22:
	rlc r1,0x0
L_931b26:
	lsr r0,r40,0x14
L_931b2a:
	bmsk_s r0,r0,0x3
L_931b2c:
	cmp_s r0,0x2
L_931b2e:
	rlc r2,0x0
L_931b32:
	lsr r0,r40,0x18
L_931b36:
	bmsk_s r0,r0,0x3
L_931b38:
	cmp_s r0,0x2
L_931b3a:
	rlc r3,0x0
L_931b3e:
	lsr r0,r40,0x1c
L_931b42:
	cmp_s r0,0x2
L_931b44:
	rlc r0,0x0
L_931b48:
	cmp_s r1,0x0
L_931b4a:
	mov.ne r14,r13
L_931b4e:
	mov.eq r14,0x0
L_931b52:
	cmp_s r2,0x0
L_931b54:
	mov.ne r1,r13
L_931b58:
	mov.eq r1,0x0
L_931b5c:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_931b5e:
	bset_s r14,r14,0x1b
L_931b60:
	or_s r14,r14,r1
L_931b62:
	cmp_s r3,0x0
L_931b64:
	mov.ne r1,r13
L_931b68:
	mov.eq r1,0x0
L_931b6c:
	cmp_s r0,0x0
L_931b6e:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_931b70:
	mov.eq r13,0x0
L_931b74:
	or_s r1,r1,r14
L_931b76:
	/* asl_s r13,r13,0x6 */
	.byte 0x06,0xbd
L_931b78:
	or_s r13,r13,r1
L_931b7a:
	ld_s r0,[gp,-0xd8]
L_931b7c:
	mov_s r1,0x800994
L_931b82:
	ld_s r1,[r1,0x8]
L_931b84:
	and_s r0,r0,r1
L_931b86:
	or_s r0,r0,r13
L_931b88:
	mov_s r32,r0
L_931b8a:
	st.ab r0,[r25,0x4]
L_931b8e:
	bclr r25,r25,0xa
L_931b92:
	b L_920284
L_931b96:
	nop_s
