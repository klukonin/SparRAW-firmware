/* sxd_hal__wait_slot2_busy @ 0x931e74, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sxd_hal.c
 * Зовут его: rx_funcs__rx_flow
 * Зовёт сам: uc_sysassert, uc_wait_event_busy
 */
	.section .text.sxd_hal__wait_slot2_busy,"ax",@progbits
	.global sxd_hal__wait_slot2_busy
sxd_hal__wait_slot2_busy:
	.global L_931e74
L_931e74:
	st.a r13,[sp,-0x8]
L_931e78:
	mov.f r13,r0
L_931e7c:
	st r14,[sp, 0x4]
L_931e80:
	bne.d L_931e98
L_931e84:
	mov_s r14,blink
L_931e86:
	mov_s r0,blink
L_931e88:
	mov_s r2,0x1000d80
L_931e8e:
	mov_s r1,0x52
L_931e90:
	bl.d L_925548
L_931e94:
	mov r3,0x13a
	.global L_931e98
L_931e98:
	mov_s r2,0x41
L_931e9a:
	asl_s r2,r2,0x13
L_931e9c:
	mov r32,r2
L_931ea0:
	st.ab r2,[r25,0x4]
L_931ea4:
	bclr r25,r25,0xa
L_931ea8:
	brhs r13,0x1,L_931eb4
	.global L_931eac
L_931eac:
	b.d L_931ee0
L_931eb0:
	mov r0,0x0
	.global L_931eb4
L_931eb4:
	mov_s r0,0x2000100
L_931eba:
	mov_s r32,r0
L_931ebc:
	st.ab r0,[r25,0x4]
L_931ec0:
	bclr r25,r25,0xa
L_931ec4:
	nop_s
L_931ec6:
	nop_s
L_931ec8:
	nop_s
L_931eca:
	mov_s r0,0x80100
L_931ed0:
	bl.d L_931808
L_931ed4:
	mov r1,0x0
L_931ed8:
	mov_s r1,r42
L_931eda:
	bbit0 r1,0x13,L_931eec
L_931ede:
	mov_s r0,0x1
	.global L_931ee0
L_931ee0:
	mov_s blink,r14
L_931ee2:
	ld_s r14,[sp,0x4]
L_931ee4:
	j.d [blink]
L_931ee8:
	ld.ab r13,[sp,0x8]
	.global L_931eec
L_931eec:
	sub r13,r13,0x1
L_931ef0:
	brhs r13,0x1,L_931eb4
L_931ef4:
	b_s L_931eac
L_931ef6:
	nop_s
