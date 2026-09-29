/* lmac_if_send_cmd_0x23 @ 0x8db04c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_mng__add_bcon, lmac_if__lmac_ready_evt, pcp_start
 * Зовёт сам: __ld_r13_to_r13_ret, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_send_cmd_0x23
lmac_if_send_cmd_0x23:
	.global L_8db04c
L_8db04c:
	push_s blink
L_8db04e:
	push_s r13
L_8db050:
	bl.d L_8c3284
L_8db054:
	mov_s r13,r0
L_8db056:
	mov_s r1,0x803c00
L_8db05c:
	ld_s r1,[r1,0xc]
L_8db05e:
	breq_s r1,0,L_8db066
L_8db060:
	mov_s r1,0x2
L_8db062:
	st_s r1,[r0]
L_8db064:
	b_s L_8db07a
	.global L_8db066
L_8db066:
	mov.f r1,r13
L_8db06a:
	mov.ne r1,0x1
L_8db06e:
	asl_s r1,r1
L_8db070:
	st_s r1,[r0]
L_8db072:
	mov_s r1,0x1
L_8db074:
	cmp_s r13,0x0
L_8db076:
	sub_s.ne r1,r1,r1
L_8db078:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8db07a
L_8db07a:
	st_s r1,[r0,0x4]
L_8db07c:
	mov_s r1,0x1
L_8db07e:
	stw_s r1,[r0,0x8]
L_8db080:
	mov_s r1,0x23
L_8db082:
	mov_s r2,0xc
L_8db084:
	bl.d L_8e5204
L_8db088:
	mov_s r3,0x0
L_8db08a:
	b L_8c025c
L_8db08e:
	nop_s
