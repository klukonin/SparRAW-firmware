/* lmac_if_send_cmd_0x21 @ 0x8d87b8, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__lmac_ready_evt
 * Зовёт сам: basic_if__alloc_mbox_slot, send_cmd2_lmac
 * Глобалы (через gp): 0x8003dc
 */
	.section .text.lmac_if_send_cmd_0x21,"ax",@progbits
	.global lmac_if_send_cmd_0x21
lmac_if_send_cmd_0x21:
	.global L_8d87b8
L_8d87b8:
	push_s blink
L_8d87ba:
	mov_s r0,0x803e3c
L_8d87c0:
	bl L_8c2c38
L_8d87c4:
	mov_s r2,r0
L_8d87c6:
	mov_s r0,0x80345c
L_8d87cc:
	ld_s r0,[r0,0xc]
L_8d87ce:
	breq_s r0,0,L_8d87d8
L_8d87d0:
	mov r0,0x500
L_8d87d4:
	st.as r0,[gp,0x9b]
	.global L_8d87d8
L_8d87d8:
	breq_s r2,0,L_8d87fa
L_8d87da:
	mov lp_count,0x4
L_8d87de:
	mov_s r1,0x0
L_8d87e0:
	lp L_8d87ee
L_8d87e4:
	ld_s r0,[gp,0x26c]
L_8d87e6:
	add1 r12,r2,r1
L_8d87ea:
	stw_s r0,[r12]
L_8d87ec:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8d87ee
L_8d87ee:
	mov_s r0,r2
L_8d87f0:
	mov_s r1,0x21
L_8d87f2:
	mov_s r2,0x8
L_8d87f4:
	bl.d L_8e0694
L_8d87f8:
	mov_s r3,0x0
	.global L_8d87fa
L_8d87fa:
	pop_s blink
L_8d87fc:
	j_s [blink]
L_8d87fe:
	nop_s
