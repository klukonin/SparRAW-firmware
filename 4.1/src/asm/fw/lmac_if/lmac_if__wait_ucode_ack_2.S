/* lmac_if__wait_ucode_ack_2 @ 0x8d8004, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   lmac_if.cpp
 * Зовут его: POWER_MNGR__halt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.lmac_if__wait_ucode_ack_2,"ax",@progbits
	.global lmac_if__wait_ucode_ack_2
lmac_if__wait_ucode_ack_2:
	.global L_8d8004
L_8d8004:
	push_s blink
L_8d8006:
	bl.d L_8c02c4
L_8d800a:
	mov_s r1,0x2
L_8d800c:
	mov_s r0,0x886d80
L_8d8012:
	st_s r1,[r0,0x58]
L_8d8014:
	sync
L_8d8018:
	mov r14,0x3e9
	.global L_8d801c
L_8d801c:
	mov lp_count,0x12c
L_8d8020:
	lp L_8d8038
L_8d8024:
	mov_s r1,0x886d80
L_8d802a:
	ld_s r13,[r1,0x50]
L_8d802c:
	lsr_s r13,r13
L_8d802e:
	bxor r13,r13,0x0
L_8d8032:
	btst_s r13,0x0
L_8d8034:
	bne_s L_8d8038
L_8d8036:
	nop_s
	.global L_8d8038
L_8d8038:
	bbit1 r13,0x0,L_8d804c
L_8d803c:
	mov_s r3,blink
L_8d803e:
	mov_s r2,0x1004fc4
L_8d8044:
	mov_s r0,0x0
L_8d8046:
	bl.d L_8edfcc
L_8d804a:
	mov_s r1,r0
	.global L_8d804c
L_8d804c:
	bbit1 r13,0x0,L_8d8056
L_8d8050:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8d8052:
	brhs r14,0x1,L_8d801c
	.global L_8d8056
L_8d8056:
	bbit0 r13,0x0,L_8d805e
	.global L_8d805a
L_8d805a:
	b L_8c0334
	.global L_8d805e
L_8d805e:
	mov_s r0,blink
L_8d8060:
	mov_s r2,0x1003e50
L_8d8066:
	mov_s r1,0x1316
L_8d806c:
	bl.d L_8c82c0
L_8d8070:
	mov r3,0x6de
L_8d8074:
	b_s L_8d805a
L_8d8076:
	nop_s
