/* hwd__apply_table_entry_b @ 0x8f2e74, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysapi__send_measure_evt
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, hwd__apply_table_entry_c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd__apply_table_entry_b
hwd__apply_table_entry_b:
	.global L_8f2e74
L_8f2e74:
	push_s blink
L_8f2e76:
	bl L_8c01d0
L_8f2e7a:
	mov_s r17,r0
L_8f2e7c:
	mov_s r13,r1
L_8f2e7e:
	mov r18,r4
L_8f2e82:
	mov_s r15,r5
L_8f2e84:
	mov r19,r6
L_8f2e88:
	mov r16,r7
L_8f2e8c:
	add.f r4,r3,r2
L_8f2e90:
	mov_s r14,0x0
L_8f2e92:
	adc r5,r14,r14
L_8f2e96:
	add_s r1,r1,0x8
L_8f2e98:
	bl.d L_8f8f60
L_8f2e9c:
	mov_s r3,r14
L_8f2e9e:
	add r1,r13,0x18
L_8f2ea2:
	mov_s r0,r17
L_8f2ea4:
	mov_s r2,r15
L_8f2ea6:
	mov_s r3,r14
L_8f2ea8:
	mov r4,r18
L_8f2eac:
	bl.d L_8f8f60
L_8f2eb0:
	mov_s r5,r14
L_8f2eb2:
	add r1,r13,0x20
L_8f2eb6:
	mov_s r0,r17
L_8f2eb8:
	mov_s r2,r16
L_8f2eba:
	mov_s r3,r14
L_8f2ebc:
	mov r4,r18
L_8f2ec0:
	bl.d L_8f8f60
L_8f2ec4:
	mov_s r5,r14
L_8f2ec6:
	add r1,r13,0x28
L_8f2eca:
	mov_s r0,r17
L_8f2ecc:
	mov_s r2,r15
L_8f2ece:
	mov_s r3,r14
L_8f2ed0:
	mov r4,r19
L_8f2ed4:
	bl.d L_8f8f60
L_8f2ed8:
	mov_s r5,r14
L_8f2eda:
	b L_8c022c
L_8f2ede:
	nop_s
