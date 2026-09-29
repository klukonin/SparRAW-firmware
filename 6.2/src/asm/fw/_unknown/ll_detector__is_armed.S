/* ll_detector__is_armed @ 0x8da35c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ka__check_peer_state, ka_detector__is_enabled, ka_necessity_detector__start_monitoring, lm_if__stop_link_a
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ll_detector__is_armed
ll_detector__is_armed:
	.global L_8da35c
L_8da35c:
	ldb r2,[r0, 0x30]
L_8da360:
	cmp r2,0xff
L_8da364:
	mov_s r1,0x0
L_8da366:
	beq_s L_8da36c
L_8da368:
	ld_s r0,[r0,0x34]
L_8da36a:
	brne_s r0,0,L_8da370
	.global L_8da36c
L_8da36c:
	mov_s r0,r1
L_8da36e:
	b_s L_8da372
	.global L_8da370
L_8da370:
	mov_s r0,0x1
	.global L_8da372
L_8da372:
	j_s.d [blink]
L_8da374:
	extb_s r0,r0
L_8da376:
	nop_s
