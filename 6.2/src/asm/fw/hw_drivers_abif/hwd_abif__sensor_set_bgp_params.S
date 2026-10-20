/* hwd_abif__sensor_set_bgp_params @ 0x8cfa24, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__sensor_set_bgp_params
hwd_abif__sensor_set_bgp_params:
	.global L_8cfa24
L_8cfa24:
	push_s blink
L_8cfa26:
	bl L_8c01d8
L_8cfa2a:
	xor r14,r0,0x1e
L_8cfa2e:
	bic.f 0x0,r14,0x3f
L_8cfa32:
	mov_s r16,r1
L_8cfa34:
	mov_s r17,r2
L_8cfa36:
	bne_s L_8cfa80
	.global L_8cfa38
L_8cfa38:
	xor r16,r16,0x12
L_8cfa3c:
	bic.f 0x0,r16,0x3f
L_8cfa40:
	bne_s L_8cfa8a
	.global L_8cfa42
L_8cfa42:
	xor r13,r17,0x34
L_8cfa46:
	bic.f 0x0,r13,0x3f
L_8cfa4a:
	bne_s L_8cfa94
	.global L_8cfa4c
L_8cfa4c:
	mov_s r1,0x889300
L_8cfa52:
	ld_s r2,[r1,0x64]
L_8cfa54:
	asl_s r14,r14,0x8
L_8cfa56:
	mov_s r0,0xffc0ffff
L_8cfa5c:
	mov_s r3,0xffc0c0ff
L_8cfa62:
	and_s r2,r2,r3
L_8cfa64:
	and_s r14,r14,r0
L_8cfa66:
	or_s r2,r2,r14
L_8cfa68:
	asl r0,r16,0x10
L_8cfa6c:
	or_s r0,r0,r2
L_8cfa6e:
	and r0,r0,0xc0ffffff
L_8cfa76:
	asl_s r13,r13,0x18
L_8cfa78:
	or_s r13,r13,r0
L_8cfa7a:
	st_s r13,[r1,0x64]
L_8cfa7c:
	b L_8c023c
	.global L_8cfa80
L_8cfa80:
	mov_s r0,blink
L_8cfa82:
	bl.d L_8c9b28
L_8cfa86:
	mov_s r1,0xaf
L_8cfa88:
	b_s L_8cfa38
	.global L_8cfa8a
L_8cfa8a:
	mov_s r0,blink
L_8cfa8c:
	bl.d L_8c9b28
L_8cfa90:
	mov_s r1,0xb0
L_8cfa92:
	b_s L_8cfa42
	.global L_8cfa94
L_8cfa94:
	mov_s r0,blink
L_8cfa96:
	bl.d L_8c9b28
L_8cfa9a:
	mov_s r1,0xb1
L_8cfa9c:
	b_s L_8cfa4c
L_8cfa9e:
	nop_s
