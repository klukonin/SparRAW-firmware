/* baseband__identify @ 0x8f4c9c, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Baseband type is BASEBAND_UNKNOWN, dev_id (0x%x)
 *   Baseband type is BASEBAND_SPARROW_M_A0
 *   Baseband type is BASEBAND_SPARROW_M_A1
 *   Baseband type is BASEBAND_SPARROW_M_D0, baseband_mask (0x%x)
 *   Baseband type is BASEBAND_SPARROW_M_C0 (Talyn TestChip), baseband_mask (0x%x)
 *   Baseband type is BASEBAND_SPARROW_M_B0, baseband_mask (0x%x)
 * Зовут его: fw_main
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global baseband__identify
baseband__identify:
	.global L_8f4c9c
L_8f4c9c:
	push_s blink
L_8f4c9e:
	push_s r13
L_8f4ca0:
	mov_s r0,0x0
L_8f4ca2:
	mov_s r13,0x880a7c
L_8f4ca8:
	stw_s r0,[r13,0x10]
L_8f4caa:
	mov_s r0,0x880b00
L_8f4cb0:
	ld_s r2,[r0,0x34]
L_8f4cb2:
	breq r2,0x632072f,L_8f4cd8
L_8f4cba:
	breq r2,0x1632072f,L_8f4ce8
L_8f4cc2:
	breq r2,0x2632072f,L_8f4cf8
L_8f4cca:
	mov_s r1,0x1000b3c
L_8f4cd0:
	bl.d L_8dcc10
L_8f4cd4:
	mov_s r0,0x20
L_8f4cd6:
	b_s L_8f4d38
	.global L_8f4cd8
L_8f4cd8:
	mov_s r1,0x1000b70
L_8f4cde:
	bl.d L_8dcba8
L_8f4ce2:
	mov_s r0,0x20
L_8f4ce4:
	mov_s r0,0x3
L_8f4ce6:
	b_s L_8f4d36
	.global L_8f4ce8
L_8f4ce8:
	mov_s r1,0x1000b98
L_8f4cee:
	bl.d L_8dcba8
L_8f4cf2:
	mov_s r0,0x20
L_8f4cf4:
	mov_s r0,0x4
L_8f4cf6:
	b_s L_8f4d36
	.global L_8f4cf8
L_8f4cf8:
	mov_s r0,0x88af80
L_8f4cfe:
	ld_s r2,[r0,0x64]
L_8f4d00:
	bbit0 r2,0x1,L_8f4d14
L_8f4d04:
	mov_s r1,0x1000bc0
L_8f4d0a:
	bl.d L_8dcc10
L_8f4d0e:
	mov_s r0,0x20
L_8f4d10:
	mov_s r0,0x7
L_8f4d12:
	b_s L_8f4d36
	.global L_8f4d14
L_8f4d14:
	bbit0 r2,0x0,L_8f4d28
L_8f4d18:
	mov_s r1,0x1000c00
L_8f4d1e:
	bl.d L_8dcc10
L_8f4d22:
	mov_s r0,0x20
L_8f4d24:
	mov_s r0,0x6
L_8f4d26:
	b_s L_8f4d36
	.global L_8f4d28
L_8f4d28:
	mov_s r1,0x1000c50
L_8f4d2e:
	bl.d L_8dcc10
L_8f4d32:
	mov_s r0,0x20
L_8f4d34:
	mov_s r0,0x5
	.global L_8f4d36
L_8f4d36:
	stw_s r0,[r13,0x10]
	.global L_8f4d38
L_8f4d38:
	b L_8c025c
