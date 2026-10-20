/* mac_ring_disable @ 0x8e508c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__teardown, vring_macq_delete_step
 */
	.section .text.mac_ring_disable,"ax",@progbits
	.global mac_ring_disable
mac_ring_disable:
	.global L_8e508c
L_8e508c:
	push_s r13
L_8e508e:
	mov_s r2,0x886a00
L_8e5094:
	ld_s r1,[r2,0x1c]
L_8e5096:
	mov_s r13,0x1
L_8e5098:
	mov_s r3,0x0
L_8e509a:
	bset r3,r3,r0
L_8e509e:
	bic_s r1,r1,r3
L_8e50a0:
	st_s r3,[r2,0x18]
L_8e50a2:
	st_s r1,[r2,0x1c]
L_8e50a4:
	st_s r13,[r2,0x20]
L_8e50a6:
	j_s.d [blink]
L_8e50a8:
	pop_s r13
L_8e50aa:
	nop_s
