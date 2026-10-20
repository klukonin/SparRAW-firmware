/* power_mngr__load_defaults @ 0x8d8d74, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mngr__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, g__set_defaults_803d90_803d94__8e64e0, memcpy_fw
 * Глобалы (через gp): 0x800380
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_mngr__load_defaults
power_mngr__load_defaults:
	.global L_8d8d74
L_8d8d74:
	push_s blink
L_8d8d76:
	bl L_8c01e0
L_8d8d7a:
	bl.d L_8e64e0
L_8d8d7e:
	mov_s r14,0x0
L_8d8d80:
	mov_s r13,0x803d5c
L_8d8d86:
	add2 r0,r13,0x11
L_8d8d8a:
	st.as r0,[gp,0x7f]
L_8d8d8e:
	st_s r14,[r13,0x24]
L_8d8d90:
	mov_s r15,0x800a60
L_8d8d96:
	add r0,r13,0x28
L_8d8d9a:
	mov_s r1,r15
L_8d8d9c:
	bl.d L_8c0380
L_8d8da0:
	mov_s r2,0xa
L_8d8da2:
	st_s r14,[r13,0x4]
L_8d8da4:
	add r0,r13,0x8
L_8d8da8:
	add r1,r15,0xa
L_8d8dac:
	bl.d L_8c0380
L_8d8db0:
	mov_s r2,0x19
L_8d8db2:
	b L_8c024c
L_8d8db6:
	nop_s
