/* sm_pring__connectivity_update @ 0x8e4ea8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sm_pring_connectivity.cpp
 * Зовут его: sm_pring__notify_if_changed
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, sm_pring__notify_vring_state
 */
	.section .text.sm_pring__connectivity_update,"ax",@progbits
	.global sm_pring__connectivity_update
sm_pring__connectivity_update:
	.global L_8e4ea8
L_8e4ea8:
	push_s blink
L_8e4eaa:
	bl L_8c02bc
L_8e4eae:
	mov_s r13,r0
L_8e4eb0:
	ld_s r0,[r0,0x24]
L_8e4eb2:
	mov_s r16,r1
L_8e4eb4:
	breq_s r0,0,L_8e4ec6
	.global L_8e4eb6
L_8e4eb6:
	mov_s r0,0x0
L_8e4eb8:
	st_s r0,[r13,0x24]
L_8e4eba:
	ldw_s r0,[r13]
L_8e4ebc:
	bl.d L_8e4df4
L_8e4ec0:
	mov_s r1,r16
L_8e4ec2:
	b L_8c0324
	.global L_8e4ec6
L_8e4ec6:
	mov_s r0,blink
L_8e4ec8:
	mov_s r2,0x100ec18
L_8e4ece:
	mov_s r1,0x12a3
L_8e4ed4:
	bl.d L_8c82c0
L_8e4ed8:
	mov_s r3,0xcd
L_8e4eda:
	b_s L_8e4eb6
