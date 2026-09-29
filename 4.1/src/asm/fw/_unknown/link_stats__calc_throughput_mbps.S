/* link_stats__calc_throughput_mbps @ 0x8c4a00, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dashboard__update_rs_result, fill_statistics_to_host
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_div_unsigned, link_stats__mcs_to_rate_mbps
 */
	.section .text.link_stats__calc_throughput_mbps,"ax",@progbits
	.global link_stats__calc_throughput_mbps
link_stats__calc_throughput_mbps:
	.global L_8c4a00
L_8c4a00:
	push_s blink
L_8c4a02:
	bl L_8c02c4
L_8c4a06:
	mov_s r13,r0
L_8c4a08:
	mov_s r14,r1
L_8c4a0a:
	brlt.d r2,0x1,L_8c4a20
L_8c4a0e:
	mov_s r0,r2
L_8c4a10:
	brge r0,0xd,L_8c4a20
L_8c4a14:
	cmp_s r0,0x5
L_8c4a16:
	cmp.ne r0,0x9
L_8c4a1a:
	beq_s L_8c4a20
L_8c4a1c:
	brge r13,0x1,L_8c4a24
	.global L_8c4a20
L_8c4a20:
	mov_s r0,0x0
L_8c4a22:
	b_s L_8c4a3a
	.global L_8c4a24
L_8c4a24:
	bl L_8d9e0c
L_8c4a28:
	sub r1,r13,r14
L_8c4a2c:
	extb_s r1,r1
L_8c4a2e:
	mulu64 r1,r0
L_8c4a32:
	mov_s r0,mlo
L_8c4a34:
	bl.d L_8c03b4
L_8c4a38:
	mov_s r1,r13
	.global L_8c4a3a
L_8c4a3a:
	b L_8c0334
L_8c4a3e:
	nop_s
