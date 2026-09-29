/* rs_done__snapshot_stats @ 0x8c25b8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__rs_done_evt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, get_reg_880a3c_8d7210, memcpy_fw, rs__inject_evt2
 */
	.section .text.rs_done__snapshot_stats,"ax",@progbits
	.global rs_done__snapshot_stats
rs_done__snapshot_stats:
	.global L_8c25b8
L_8c25b8:
	push_s blink
L_8c25ba:
	bl L_8c02c4
L_8c25be:
	mov_s r14,r0
L_8c25c0:
	bl.d L_8d7210
L_8c25c4:
	mov_s r13,r1
L_8c25c6:
	brne_s r0,0,L_8c25e0
L_8c25c8:
	add r0,r14,0x2c
L_8c25cc:
	mov_s r1,r13
L_8c25ce:
	bl.d L_8c0460
L_8c25d2:
	mov_s r2,0x10
L_8c25d4:
	ld_s r0,[r14]
L_8c25d6:
	cmp_s r0,0x0
L_8c25d8:
	bl.ne.d L_8dbf14
L_8c25dc:
	mov.ne r1,r13
	.global L_8c25e0
L_8c25e0:
	b L_8c0334
