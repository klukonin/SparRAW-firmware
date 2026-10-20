/* uc_read_bi_sync @ 0x936b60, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager_step_a, bti__bi2_event_step
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_read_bi_sync
uc_read_bi_sync:
	.global L_936b60
L_936b60:
	push_s blink
L_936b62:
	ld_s r0,[gp,-0x44]
L_936b64:
	and r0,r0,0xffff0fff
L_936b6c:
	bset r1,r0,0xe
L_936b70:
	or r0,r0,0x1d004000
L_936b78:
	st.as r1,[gp,-0x11]
L_936b7c:
	mov_s r32,r0
L_936b7e:
	st.ab r0,[r25,0x4]
L_936b82:
	bclr r25,r25,0xa
L_936b86:
	nop_s
L_936b88:
	nop_s
L_936b8a:
	nop_s
L_936b8c:
	lsr r0,r40,0x1f
L_936b90:
	pop_s blink
L_936b92:
	j_s [blink]
