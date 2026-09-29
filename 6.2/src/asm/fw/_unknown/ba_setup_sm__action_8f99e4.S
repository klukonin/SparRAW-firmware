/* ba_setup_sm__action_8f99e4 @ 0x8f99e4, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, ba__retry_flow, fw_sysassert_fatal, u_schd__schedule
 * Глобалы (через gp): 0x8002b8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__action_8f99e4
ba_setup_sm__action_8f99e4:
	.global L_8f99e4
L_8f99e4:
	push_s blink
L_8f99e6:
	push_s r13
L_8f99e8:
	mov_s r13,r0
L_8f99ea:
	ld_s r0,[r0,0x14]
L_8f99ec:
	brne_s r0,0,L_8f9a12
	.global L_8f99ee
L_8f99ee:
	mov_s r0,0x313b4
L_8f99f4:
	ld.as r4,[gp,0x4d]
L_8f99f8:
	mov_s r1,r13
L_8f99fa:
	mov_s r2,0x0
L_8f99fc:
	mov_s r3,r2
L_8f99fe:
	mov_s r5,r2
L_8f9a00:
	bl.d L_8e0c0c
L_8f9a04:
	mov_s r6,r2
L_8f9a06:
	st_s r0,[r13,0x14]
L_8f9a08:
	bl.d L_8f1a48
L_8f9a0c:
	mov_s r0,r13
L_8f9a0e:
	b L_8c025c
	.global L_8f9a12
L_8f9a12:
	mov_s r0,blink
L_8f9a14:
	mov_s r1,0x129a
L_8f9a1a:
	bl L_8c9b28
L_8f9a1e:
	b_s L_8f99ee
