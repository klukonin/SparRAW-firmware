/* rf_cfg__load_800d04 @ 0x8e6e8c, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_set_high_power_table_params
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_cfg__load_800d04
rf_cfg__load_800d04:
	.global L_8e6e8c
L_8e6e8c:
	push_s blink
L_8e6e8e:
	bl.d L_8c01e4
L_8e6e92:
	mov_s r2,0x3
L_8e6e94:
	mov_s r14,r0
L_8e6e96:
	mov_s r13,0x800d04
L_8e6e9c:
	mov_s r0,r13
L_8e6e9e:
	bl.d L_8c0380
L_8e6ea2:
	mov_s r1,r14
L_8e6ea4:
	add_s r0,r13,0x4
L_8e6ea6:
	add_s r1,r14,0x4
L_8e6ea8:
	bl.d L_8c0380
L_8e6eac:
	mov_s r2,0x10
L_8e6eae:
	add r0,r13,0x14
L_8e6eb2:
	add r1,r14,0x14
L_8e6eb6:
	bl.d L_8c0380
L_8e6eba:
	mov_s r2,0x3
L_8e6ebc:
	add r0,r13,0x18
L_8e6ec0:
	add r1,r14,0x18
L_8e6ec4:
	bl.d L_8c0380
L_8e6ec8:
	mov_s r2,0x20
L_8e6eca:
	add r0,r13,0x38
L_8e6ece:
	add r1,r14,0x38
L_8e6ed2:
	bl.d L_8c0380
L_8e6ed6:
	mov_s r2,0x3
L_8e6ed8:
	add r0,r13,0x3c
L_8e6edc:
	add r1,r14,0x3c
L_8e6ee0:
	bl.d L_8c0380
L_8e6ee4:
	mov_s r2,0x10
L_8e6ee6:
	add2 r0,r13,0x13
L_8e6eea:
	add2 r1,r14,0x13
L_8e6eee:
	bl.d L_8c0380
L_8e6ef2:
	mov_s r2,0x3
L_8e6ef4:
	add3 r0,r13,0xa
L_8e6ef8:
	add3 r1,r14,0xa
L_8e6efc:
	bl.d L_8c0380
L_8e6f00:
	mov_s r2,0x20
L_8e6f02:
	add3 r0,r13,0xe
L_8e6f06:
	add3 r1,r14,0xe
L_8e6f0a:
	bl.d L_8c0380
L_8e6f0e:
	mov_s r2,0x3
L_8e6f10:
	mov_s r0,r13
L_8e6f12:
	add_s r0,r0,0x73
L_8e6f14:
	add2 r1,r14,0x1d
L_8e6f18:
	bl.d L_8c0380
L_8e6f1c:
	mov_s r2,0x4
L_8e6f1e:
	b L_8c0254
L_8e6f22:
	nop_s
