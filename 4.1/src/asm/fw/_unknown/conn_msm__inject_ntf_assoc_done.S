/* conn_msm__inject_ntf_assoc_done @ 0x8da460, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_notify
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, tail_conn_mgr__ranking_remove
 */
	.section .text.conn_msm__inject_ntf_assoc_done,"ax",@progbits
	.global conn_msm__inject_ntf_assoc_done
conn_msm__inject_ntf_assoc_done:
	.global L_8da460
L_8da460:
	push_s blink
L_8da462:
	push_s r13
L_8da464:
	bl.d L_8e2758
L_8da468:
	mov_s r13,r0
L_8da46a:
	add2 r0,r13,0x3f
L_8da46e:
	mov_s r1,0x5
L_8da470:
	mov_s r2,0x0
L_8da472:
	mov_s r3,r2
L_8da474:
	bl.d L_8d6a1c
L_8da478:
	mov_s r4,r2
L_8da47a:
	b L_8c033c
L_8da47e:
	nop_s
