/* ba_sm__prepare_ba_td_8e0ddc @ 0x8e0ddc, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_sm::prepare_ba_td: Vring Index: %d, Pring Index: %d, CID: %d
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, ba_sm__get_param_byte6, ba_sm__get_param_byte7, basic_sm__handle_event, fw_log_emit3, vring__get_pring_id_of_obj
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__prepare_ba_td_8e0ddc
ba_sm__prepare_ba_td_8e0ddc:
	.global L_8e0ddc
L_8e0ddc:
	push_s blink
L_8e0dde:
	bl L_8c01dc
L_8e0de2:
	mov_s r13,r0
L_8e0de4:
	bl.d L_8cce9c
L_8e0de8:
	mov_s r16,r1
L_8e0dea:
	mov_s r15,r0
L_8e0dec:
	bl.d L_8cca30
L_8e0df0:
	mov_s r0,r13
L_8e0df2:
	mov_s r14,r0
L_8e0df4:
	bl.d L_8cbec8
L_8e0df8:
	mov_s r0,r13
L_8e0dfa:
	mov_s r4,r0
L_8e0dfc:
	mov_s r1,0x1013500
L_8e0e02:
	mov_s r0,0x2b
L_8e0e04:
	mov_s r2,r15
L_8e0e06:
	bl.d L_8dcd00
L_8e0e0a:
	mov_s r3,r14
L_8e0e0c:
	add r0,r13,0x2c
L_8e0e10:
	mov_s r1,0x0
L_8e0e12:
	mov_s r2,r16
L_8e0e14:
	mov_s r3,0x1
L_8e0e16:
	bl.d L_8d9b6c
L_8e0e1a:
	mov_s r4,r1
L_8e0e1c:
	ld_s r0,[r13,0x40]
L_8e0e1e:
	ld_s r1,[r0,0x68]
L_8e0e20:
	ld_s r1,[r1,0x8]
L_8e0e22:
	jl_s [r1]
L_8e0e24:
	b L_8c0244
