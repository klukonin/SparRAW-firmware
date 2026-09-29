/* conn_msm__on_ntf_disc_complete @ 0x8c79f4, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, assoc_ready_check_trig, rf__apply_tx_power, u_schd__add
 */
	.section .text.conn_msm__on_ntf_disc_complete,"ax",@progbits
	.global conn_msm__on_ntf_disc_complete
conn_msm__on_ntf_disc_complete:
L_8c79f4:
	push_s blink
L_8c79f6:
	bl L_8c02c0
L_8c79fa:
	mov_s r13,r0
L_8c79fc:
	mov_s r14,r1
L_8c79fe:
	ld_s r0,[r0,0x2c]
L_8c7a00:
	asl r15,r2,0x10
L_8c7a04:
	bl.d L_8c33f4
L_8c7a08:
	ld_s r0,[r0,0xc]
L_8c7a0a:
	mov_s r0,0x2b270
L_8c7a10:
	ld_s r1,[r13,0x2c]
L_8c7a12:
	or r2,r15,r14
L_8c7a16:
	bl.d L_8c2ac8
L_8c7a1a:
	mov_s r3,0x1
L_8c7a1c:
	ld_s r0,[r13,0x2c]
L_8c7a1e:
	ld_s r1,[r0,0xc]
L_8c7a20:
	ld_s r1,[r1,0x50]
L_8c7a22:
	mov_s r0,0x0
L_8c7a24:
	cmp_s r1,0x2
L_8c7a26:
	cmp.ne r1,0x3
L_8c7a2a:
	mov.eq r0,0x1
L_8c7a2e:
	extb.f 0x0,r0
L_8c7a32:
	bl.eq.d L_8de0d8
L_8c7a36:
	mov.eq r0,0x0
L_8c7a3a:
	.byte 0xf5,0x00
