/* lmac_if_send_cmd_0x01 @ 0x8dbd2c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_ch_switch_sm__switch_on
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, lmac_if__build_rx_on_cmd, lmac_if__post_cmd, mem_pool__alloc_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_send_cmd_0x01
lmac_if_send_cmd_0x01:
	.global L_8dbd2c
L_8dbd2c:
	sub_s sp,sp,0x8
L_8dbd2e:
	push_s blink
L_8dbd30:
	bl L_8c01d4
L_8dbd34:
	mov_s r13,r0
L_8dbd36:
	mov_s r15,r1
L_8dbd38:
	mov_s r18,r2
L_8dbd3a:
	mov_s r17,r3
L_8dbd3c:
	mov_s r0,0x804280
L_8dbd42:
	bl.d L_8c33d0
L_8dbd46:
	mov r16,r4
L_8dbd4a:
	mov.f r14,r0
L_8dbd4e:
	beq_s L_8dbd6e
L_8dbd50:
	mov_s r1,r13
L_8dbd52:
	mov_s r2,r15
L_8dbd54:
	mov_s r3,r18
L_8dbd56:
	mov r4,r17
L_8dbd5a:
	bl.d L_8dbcdc
L_8dbd5e:
	mov r5,r16
L_8dbd62:
	mov_s r0,r14
L_8dbd64:
	mov_s r1,0x1
L_8dbd66:
	mov_s r2,0x28
L_8dbd68:
	bl.d L_8e5204
L_8dbd6c:
	mov_s r3,0x0
	.global L_8dbd6e
L_8dbd6e:
	mov_s r12,0xc
L_8dbd70:
	b L_8c0236
