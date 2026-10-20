/* lmac_if_send_cmd_0x01 @ 0x8d8a14, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_ch_switch_sm__switch_on
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, basic_if__alloc_mbox_slot, lmac_if__build_cmd_0x01, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x01,"ax",@progbits
	.global lmac_if_send_cmd_0x01
lmac_if_send_cmd_0x01:
	.global L_8d8a14
L_8d8a14:
	sub_s sp,sp,0x8
L_8d8a16:
	push_s blink
L_8d8a18:
	bl L_8c02b4
L_8d8a1c:
	mov_s r13,r0
L_8d8a1e:
	mov_s r15,r1
L_8d8a20:
	mov_s r18,r2
L_8d8a22:
	mov_s r17,r3
L_8d8a24:
	mov_s r0,0x803e3c
L_8d8a2a:
	bl.d L_8c2c38
L_8d8a2e:
	mov r16,r4
L_8d8a32:
	mov.f r14,r0
L_8d8a36:
	beq_s L_8d8a56
L_8d8a38:
	mov_s r1,r13
L_8d8a3a:
	mov_s r2,r15
L_8d8a3c:
	mov_s r3,r18
L_8d8a3e:
	mov r4,r17
L_8d8a42:
	bl.d L_8d89f0
L_8d8a46:
	mov r5,r16
L_8d8a4a:
	mov_s r0,r14
L_8d8a4c:
	mov_s r1,0x1
L_8d8a4e:
	mov_s r2,0x24
L_8d8a50:
	bl.d L_8e0694
L_8d8a54:
	mov_s r3,0x0
	.global L_8d8a56
L_8d8a56:
	mov_s r12,0xc
L_8d8a58:
	b L_8c0316
