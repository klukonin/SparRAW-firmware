/* link_stats_sm__arm_report_timer @ 0x8e4910, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__report, sm_802f58__action_8e774c
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_stats_sm__arm_report_timer
link_stats_sm__arm_report_timer:
	.global L_8e4910
L_8e4910:
	push_s blink
L_8e4912:
	push_s r13
L_8e4914:
	mov_s r13,r0
L_8e4916:
	ld_s r0,[r0,0xc]
L_8e4918:
	brne_s r0,0,L_8e493c
	.global L_8e491a
L_8e491a:
	mov_s r0,0x19c2c
L_8e4920:
	mov_s r1,r13
L_8e4922:
	mov_s r2,0x0
L_8e4924:
	mov_s r3,r2
L_8e4926:
	mov r4,0x186a0
L_8e492e:
	mov_s r5,r2
L_8e4930:
	bl.d L_8e0c0c
L_8e4934:
	mov_s r6,r2
L_8e4936:
	b.d L_8c025c
L_8e493a:
	st_s r0,[r13,0xc]
	.global L_8e493c
L_8e493c:
	mov_s r0,blink
L_8e493e:
	mov_s r1,0x1258
L_8e4944:
	bl L_8c9b28
L_8e4948:
	b_s L_8e491a
L_8e494a:
	nop_s
