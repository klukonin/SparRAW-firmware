/* bi__state_from_g800600 @ 0x9282b4, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_bi_step, bi__after_enter_aw, bi__after_enter_dti, rx_nav__set_from_duration
 * Зовёт сам: uc_sysassert
 * Глобалы (через gp): 0x800600
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi__state_from_g800600
bi__state_from_g800600:
	.global L_9282b4
L_9282b4:
	st.a r13,[sp,-0x8]
L_9282b8:
	st_s r14,[sp,0x4]
L_9282ba:
	ldb_s r0,[gp,0xd8]
L_9282bc:
	mov r14,blink
L_9282c0:
	breq.d r0,0x0,L_9282fc
L_9282c4:
	mov_s r13,0x0
L_9282c6:
	breq r0,0x2,L_9282e4
L_9282ca:
	breq r0,0x3,L_9282f0
L_9282ce:
	mov_s r0,blink
L_9282d0:
	bl.d L_926618
L_9282d4:
	mov r1,0x5f
L_9282d8:
	mov_s r0,r13
L_9282da:
	mov_s blink,r14
L_9282dc:
	ld_s r14,[sp,0x4]
L_9282de:
	j_s.d [blink]
L_9282e0:
	ld.ab r13,[sp,0x8]
	.global L_9282e4
L_9282e4:
	mov_s r0,0x1
L_9282e6:
	mov_s blink,r14
L_9282e8:
	ld_s r14,[sp,0x4]
L_9282ea:
	j_s.d [blink]
L_9282ec:
	ld.ab r13,[sp,0x8]
	.global L_9282f0
L_9282f0:
	mov_s r0,0x2
L_9282f2:
	mov_s blink,r14
L_9282f4:
	ld_s r14,[sp,0x4]
L_9282f6:
	j_s.d [blink]
L_9282f8:
	ld.ab r13,[sp,0x8]
	.global L_9282fc
L_9282fc:
	mov_s r0,r13
L_9282fe:
	mov_s blink,r14
L_928300:
	ld_s r14,[sp,0x4]
L_928302:
	j_s.d [blink]
L_928304:
	ld.ab r13,[sp,0x8]
