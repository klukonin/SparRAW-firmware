/* rx_cfg__select_sta @ 0x934e18, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm2, internal_tx__flow_sm4, internal_tx__flow_sm6, l1_fixed_sched_ap__ev4_state2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_cfg__select_sta
rx_cfg__select_sta:
	.global L_934e18
L_934e18:
	mov_s r1,0x801110
L_934e1e:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_934e20:
	add2_s r0,r0,r0
L_934e22:
	ld_s r1,[r1,r0]
L_934e24:
	mov_s r0,0x801024
L_934e2a:
	j_s.d [blink]
L_934e2c:
	st_s r1,[r0]
L_934e2e:
	nop_s
