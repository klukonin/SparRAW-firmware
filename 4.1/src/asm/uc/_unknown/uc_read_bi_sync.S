/* uc_read_bi_sync @ 0x931c64, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager_step_a, bti__bi2_event_step
 */
	.section .text.uc_read_bi_sync,"ax",@progbits
	.global uc_read_bi_sync
uc_read_bi_sync:
	.global L_931c64
L_931c64:
	push_s blink
L_931c66:
	ld_s r0,[gp,-0x44]
L_931c68:
	and r0,r0,0xffff0fff
L_931c70:
	bset r1,r0,0xe
L_931c74:
	or r0,r0,0x1d004000
L_931c7c:
	st.as r1,[gp,-0x11]
L_931c80:
	mov_s r32,r0
L_931c82:
	st.ab r0,[r25,0x4]
L_931c86:
	bclr r25,r25,0xa
L_931c8a:
	nop_s
L_931c8c:
	nop_s
L_931c8e:
	nop_s
L_931c90:
	lsr r0,r40,0x1f
L_931c94:
	pop_s blink
L_931c96:
	j_s [blink]
