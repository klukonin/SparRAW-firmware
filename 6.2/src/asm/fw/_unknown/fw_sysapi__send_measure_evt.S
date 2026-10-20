/* fw_sysapi__send_measure_evt @ 0x8f8af8, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysapi_mgr__phy_rx_statistics_cmd_start
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_divmod64_signed, fw_mul64, fw_sysapi_mgr__send_evt2host, hwd__apply_table_entry, hwd__apply_table_entry_b, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi__send_measure_evt
fw_sysapi__send_measure_evt:
	.global L_8f8af8
L_8f8af8:
	push_s blink
L_8f8afa:
	bl L_8c01dc
L_8f8afe:
	sub sp,sp,0x8c
L_8f8b02:
	mov_s r15,r0
L_8f8b04:
	mov_s r14,r1
L_8f8b06:
	mov_s r0,sp
L_8f8b08:
	bl.d L_8c1cd8
L_8f8b0c:
	mov_s r1,0x8c
L_8f8b0e:
	add r13,r14,0x38
L_8f8b12:
	mov r16,sp
L_8f8b16:
	add r3,r13,0x8
L_8f8b1a:
	add r4,r13,0x10
L_8f8b1e:
	add r5,r13,0x18
L_8f8b22:
	mov_s r0,r15
L_8f8b24:
	mov_s r1,r16
L_8f8b26:
	bl.d L_8f2e0c
L_8f8b2a:
	mov_s r2,r13
L_8f8b2c:
	ld r4,[r14]
L_8f8b30:
	mov_s r0,r15
L_8f8b32:
	ld r5,[r14, 0x10]
L_8f8b36:
	mov_s r1,r16
L_8f8b38:
	ld r6,[r14, 0x4]
L_8f8b3c:
	ld r7,[r14, 0x8]
L_8f8b40:
	ld_s r2,[r14,0x18]
L_8f8b42:
	bl.d L_8f2e74
L_8f8b46:
	ld_s r3,[r14,0x14]
L_8f8b48:
	add3 r16,sp,0x8
L_8f8b4c:
	add r2,r13,0x20
L_8f8b50:
	add r3,r13,0x28
L_8f8b54:
	add r4,r13,0x30
L_8f8b58:
	add r5,r13,0x38
L_8f8b5c:
	mov_s r0,r15
L_8f8b5e:
	bl.d L_8f2e0c
L_8f8b62:
	mov_s r1,r16
L_8f8b64:
	ld r4,[r14, 0x1c]
L_8f8b68:
	mov_s r0,r15
L_8f8b6a:
	ld r5,[r14, 0x2c]
L_8f8b6e:
	mov_s r1,r16
L_8f8b70:
	ld r6,[r14, 0x20]
L_8f8b74:
	ld r7,[r14, 0x24]
L_8f8b78:
	ld_s r2,[r14,0x34]
L_8f8b7a:
	bl.d L_8f2e74
L_8f8b7e:
	ld_s r3,[r14,0x30]
L_8f8b80:
	ld_s r13,[sp,0x34]
L_8f8b82:
	breq_s r13,0,L_8f8ba6
L_8f8b84:
	ld_s r1,[r14,0x78]
L_8f8b86:
	mov_s r0,0x8012f0
L_8f8b8c:
	ldw.as r2,[r0,r1]
L_8f8b90:
	mov_s r1,0x0
L_8f8b92:
	ld_s r0,[sp,0x30]
L_8f8b94:
	bl.d L_8c045c
L_8f8b98:
	mov_s r3,r1
L_8f8b9a:
	mov_s r2,r13
L_8f8b9c:
	bl.d L_8c047c
L_8f8ba0:
	mov_s r3,0x0
L_8f8ba2:
	st r0,[sp, 0x80]
	.global L_8f8ba6
L_8f8ba6:
	ld_s r0,[r14,0x7c]
L_8f8ba8:
	mov_s r2,sp
L_8f8baa:
	st r0,[sp, 0x84]
L_8f8bae:
	ld r0,[r14, 0x80]
L_8f8bb2:
	add r4,r15,0x4
L_8f8bb6:
	st r0,[sp, 0x88]
L_8f8bba:
	ld_s r1,[r15,0x20]
L_8f8bbc:
	mov_s r0,r15
L_8f8bbe:
	bl.d L_8f8948
L_8f8bc2:
	mov_s r3,0x8c
L_8f8bc4:
	b.d L_8c0244
L_8f8bc8:
	add sp,sp,0x8c
