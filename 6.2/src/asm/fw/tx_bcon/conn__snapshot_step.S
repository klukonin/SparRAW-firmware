/* conn__snapshot_step @ 0x8c28d0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__snapshot_bcon_ts, lmac_if__abft_notify_evt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hw__is_fpga_platform, memcpy_fw, tx_bcon__inject_evt4, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__snapshot_step
conn__snapshot_step:
	.global L_8c28d0
L_8c28d0:
	push_s blink
L_8c28d2:
	bl L_8c01e4
L_8c28d6:
	mov_s r13,r0
L_8c28d8:
	bl.d L_8da2c8
L_8c28dc:
	mov_s r14,r1
L_8c28de:
	brne_s r0,0,L_8c28fe
L_8c28e0:
	add r0,r13,0xc
L_8c28e4:
	mov_s r1,r14
L_8c28e6:
	bl.d L_8c0380
L_8c28ea:
	mov_s r2,0x44
L_8c28ec:
	bl L_8e9524
L_8c28f0:
	st_s r0,[r13,0x8]
L_8c28f2:
	ld_s r0,[r13]
L_8c28f4:
	cmp_s r0,0x0
L_8c28f6:
	bl.ne.d L_8dffb8
L_8c28fa:
	mov.ne r1,r14
	.global L_8c28fe
L_8c28fe:
	b L_8c0254
L_8c2902:
	nop_s
