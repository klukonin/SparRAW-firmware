/* power_mngr__load_defaults @ 0x8d5b80, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, g_8035c8__set_defaults, memcpy_fw
 * Глобалы (через gp): 0x80035c
 */
	.section .text.power_mngr__load_defaults,"ax",@progbits
	.global power_mngr__load_defaults
power_mngr__load_defaults:
	.global L_8d5b80
L_8d5b80:
	push_s blink
L_8d5b82:
	bl L_8c02c0
L_8d5b86:
	bl.d L_8e173c
L_8d5b8a:
	mov_s r14,0x0
L_8d5b8c:
	mov_s r13,0x8035c8
L_8d5b92:
	add2 r0,r13,0x11
L_8d5b96:
	st.as r0,[gp,0x7b]
L_8d5b9a:
	st_s r14,[r13,0x24]
L_8d5b9c:
	mov_s r15,0x8009c4
L_8d5ba2:
	add r0,r13,0x28
L_8d5ba6:
	mov_s r1,r15
L_8d5ba8:
	bl.d L_8c0460
L_8d5bac:
	mov_s r2,0xa
L_8d5bae:
	st_s r14,[r13,0x4]
L_8d5bb0:
	add r0,r13,0x8
L_8d5bb4:
	add r1,r15,0xa
L_8d5bb8:
	bl.d L_8c0460
L_8d5bbc:
	mov_s r2,0x19
L_8d5bbe:
	b L_8c032c
L_8d5bc2:
	nop_s
