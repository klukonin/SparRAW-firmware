/* state_sm_8030f4__action_8f0dd4 @ 0x8f0dd4, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, radio_mgr__request
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_8030f4__action_8f0dd4
state_sm_8030f4__action_8f0dd4:
	.global L_8f0dd4
L_8f0dd4:
	push_s blink
L_8f0dd6:
	push_s r13
L_8f0dd8:
	mov_s r13,r0
L_8f0dda:
	add r2,r0,0x8
L_8f0dde:
	mov lp_count,0x8
L_8f0de2:
	mov_s r1,0x0
L_8f0de4:
	lp L_8f0df0
L_8f0de8:
	mov_s r0,0x8
L_8f0dea:
	add_s r12,r2,r1
L_8f0dec:
	stb_s r0,[r12]
L_8f0dee:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8f0df0
L_8f0df0:
	ld_s r0,[r13,0x10]
L_8f0df2:
	mov_s r1,r13
L_8f0df4:
	ld_s r0,[r0,0x48]
L_8f0df6:
	mov_s r3,0xffff
L_8f0dfc:
	ldb r4,[r0, 0x10]
L_8f0e00:
	mov_s r0,0x37fc0
L_8f0e06:
	bl.d L_8dcaf4
L_8f0e0a:
	mov_s r2,0x0
L_8f0e0c:
	b.d L_8c025c
L_8f0e10:
	st_s r0,[r13,0x14]
L_8f0e12:
	nop_s
