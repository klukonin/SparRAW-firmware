/* uc_pm__enter_idle @ 0x93c7d4, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_bi_step, bi__latch_tsf_and_reset, l1_task__report_link_lost
 * Зовёт сам: __ld_r13_to_r13_ret, mac__read_tsf64_uc, mac_mode__enter_idle_seq
 * Глобалы (через gp): 0x800588
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_pm__enter_idle
uc_pm__enter_idle:
	.global L_93c7d4
L_93c7d4:
	push_s blink
L_93c7d6:
	push_s r13
L_93c7d8:
	mov_s r13,r0
L_93c7da:
	mov_s r0,0x8014a4
L_93c7e0:
	bl L_9356cc
L_93c7e4:
	mov_s r0,0x0
L_93c7e6:
	st.as r0,[gp,0x18]
L_93c7ea:
	bl.d L_9375cc
L_93c7ee:
	mov_s r0,r13
L_93c7f0:
	mov_s r0,0x20c0010
L_93c7f6:
	mov_s r32,r0
L_93c7f8:
	st.ab r0,[r25,0x4]
L_93c7fc:
	bclr r25,r25,0xa
L_93c800:
	mov_s r1,0x8014c8
L_93c806:
	ld_s r0,[r1]
L_93c808:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93c80a:
	st_s r0,[r1]
L_93c80c:
	mov_s r1,0x853900
L_93c812:
	b.d L_9202ac
L_93c816:
	st_s r0,[r1,0x1c]
