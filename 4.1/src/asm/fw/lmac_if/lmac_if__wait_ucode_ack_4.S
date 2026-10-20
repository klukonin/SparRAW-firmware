/* lmac_if__wait_ucode_ack_4 @ 0x8d7f80, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   lmac_if.cpp
 * Зовут его: power_deep_sleep_exit_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.lmac_if__wait_ucode_ack_4,"ax",@progbits
	.global lmac_if__wait_ucode_ack_4
lmac_if__wait_ucode_ack_4:
	.global L_8d7f80
L_8d7f80:
	push_s blink
L_8d7f82:
	bl.d L_8c02c4
L_8d7f86:
	mov_s r1,0x4
L_8d7f88:
	mov_s r0,0x886d80
L_8d7f8e:
	st_s r1,[r0,0x58]
L_8d7f90:
	sync
L_8d7f94:
	mov r14,0x3e9
	.global L_8d7f98
L_8d7f98:
	mov_s r0,0x50
L_8d7f9a:
	mov lp_count,r0
L_8d7f9e:
	nop_s
L_8d7fa0:
	lp L_8d7fa8
L_8d7fa4:
	nop_s
L_8d7fa6:
	nop_s
	.global L_8d7fa8
L_8d7fa8:
	mov lp_count,0x12c
L_8d7fac:
	lp L_8d7fc4
L_8d7fb0:
	mov_s r1,0x886d80
L_8d7fb6:
	ld_s r13,[r1,0x50]
L_8d7fb8:
	lsr_s r13,r13,0x2
L_8d7fba:
	bxor r13,r13,0x0
L_8d7fbe:
	btst_s r13,0x0
L_8d7fc0:
	bne_s L_8d7fc4
L_8d7fc2:
	nop_s
	.global L_8d7fc4
L_8d7fc4:
	bbit1 r13,0x0,L_8d7fd8
L_8d7fc8:
	mov_s r3,blink
L_8d7fca:
	mov_s r2,0x1004fc4
L_8d7fd0:
	mov_s r0,0x0
L_8d7fd2:
	bl.d L_8edfcc
L_8d7fd6:
	mov_s r1,r0
	.global L_8d7fd8
L_8d7fd8:
	bbit1 r13,0x0,L_8d7fe2
L_8d7fdc:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8d7fde:
	brhs r14,0x1,L_8d7f98
	.global L_8d7fe2
L_8d7fe2:
	bbit0 r13,0x0,L_8d7fea
	.global L_8d7fe6
L_8d7fe6:
	b L_8c0334
	.global L_8d7fea
L_8d7fea:
	mov_s r0,blink
L_8d7fec:
	mov_s r2,0x1003e50
L_8d7ff2:
	mov_s r1,0x1317
L_8d7ff8:
	bl.d L_8c82c0
L_8d7ffc:
	mov r3,0x6f6
L_8d8000:
	b_s L_8d7fe6
L_8d8002:
	nop_s
