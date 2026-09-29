/* hwd_rfc_sector_x16_state_set @ 0x8d0cf8, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_sector_x16_state_set(): TX sector# %d activated (settings applied to current RF chain HW)
 *   hwd_rfc_sector_x16_state_set(): RX sector# %d activated (settings applied to current RF chain HW)
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_set
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit1, hwd_rfc_read_rgf, rf_sector_commit_rx, rf_sector_commit_tx, rfc_field_write
 */
	.section .text.hwd_rfc_sector_x16_state_set,"ax",@progbits
	.global hwd_rfc_sector_x16_state_set
hwd_rfc_sector_x16_state_set:
	.global L_8d0cf8
L_8d0cf8:
	push_s blink
L_8d0cfa:
	bl L_8c02b0
L_8d0cfe:
	mov_s r17,r0
L_8d0d00:
	mov_s r18,r1
L_8d0d02:
	mov.f r14,r2
L_8d0d06:
	mov_s r16,r3
L_8d0d08:
	mov r19,r4
L_8d0d0c:
	mov_s r15,r5
L_8d0d0e:
	asl_s r13,r1,0x6
L_8d0d10:
	add1_s r13,r13,r13
L_8d0d12:
	beq_s L_8d0d1e
L_8d0d14:
	add r0,r13,0x8080
L_8d0d1c:
	b_s L_8d0d26
	.global L_8d0d1e
L_8d0d1e:
	add r0,r13,0x10080
	.global L_8d0d26
L_8d0d26:
	lsr_s r0,r0,0x3
L_8d0d28:
	bic r1,r0,0x3
L_8d0d2c:
	bl.d L_8d04fc
L_8d0d30:
	mov_s r0,r17
L_8d0d32:
	bmsk r1,r16,0x0
L_8d0d36:
	add_s r1,r1,0x1c
L_8d0d38:
	bclr r2,r0,r1
L_8d0d3c:
	asl r3,r19,r1
L_8d0d40:
	breq_s r14,0,L_8d0d68
L_8d0d42:
	add_s r13,r13,0x8080
L_8d0d48:
	lsr_s r13,r13,0x3
L_8d0d4a:
	bic r1,r13,0x3
L_8d0d4e:
	mov_s r0,r17
L_8d0d50:
	bl.d L_8d113c
L_8d0d54:
	or_s r2,r2,r3
L_8d0d56:
	breq_s r15,0,L_8d0d96
L_8d0d58:
	mov_s r0,r17
L_8d0d5a:
	bl.d L_8d0ef4
L_8d0d5e:
	mov_s r1,r18
L_8d0d60:
	mov_s r2,0x10194fc
L_8d0d66:
	b_s L_8d0d8c
	.global L_8d0d68
L_8d0d68:
	add_s r13,r13,0x10080
L_8d0d6e:
	lsr_s r13,r13,0x3
L_8d0d70:
	bic r1,r13,0x3
L_8d0d74:
	mov_s r0,r17
L_8d0d76:
	bl.d L_8d113c
L_8d0d7a:
	or_s r2,r2,r3
L_8d0d7c:
	breq_s r15,0,L_8d0d96
L_8d0d7e:
	mov_s r0,r17
L_8d0d80:
	bl.d L_8d073c
L_8d0d84:
	mov_s r1,r18
L_8d0d86:
	mov_s r2,0x1019560
	.global L_8d0d8c
L_8d0d8c:
	mov_s r0,0x0
L_8d0d8e:
	mov_s r1,0x2
L_8d0d90:
	bl.d L_8edfcc
L_8d0d94:
	mov_s r3,r18
	.global L_8d0d96
L_8d0d96:
	b L_8c030c
L_8d0d9a:
	nop_s
