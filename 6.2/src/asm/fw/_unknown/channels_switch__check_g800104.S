/* channels_switch__check_g800104 @ 0x8e46f4, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__check_bad_link, maintain_sm__action_8cab64, maintain_sm__action_8e2b9c
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, u_schd__cancel, u_schd__schedule
 * Глобалы (через gp): 0x8002bc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channels_switch__check_g800104
channels_switch__check_g800104:
	.global L_8e46f4
L_8e46f4:
	push_s blink
L_8e46f6:
	bl L_8c01e4
L_8e46fa:
	mov_s r13,r0
L_8e46fc:
	ld_s r0,[gp,-0x80]
L_8e46fe:
	brne_s r0,0,L_8e472e
L_8e4700:
	ld_s r0,[r13,0x20]
L_8e4702:
	mov_s r14,0x0
L_8e4704:
	breq_s r0,0,L_8e470c
L_8e4706:
	bl L_8c8de0
L_8e470a:
	st_s r14,[r13,0x20]
	.global L_8e470c
L_8e470c:
	mov_s r0,0x1
L_8e470e:
	st_s r0,[r13,0x6c]
L_8e4710:
	st_s r14,[r13,0x70]
L_8e4712:
	st_s r14,[r13,0x74]
L_8e4714:
	mov_s r0,L_8c5ef8-0x8c0000
L_8e471a:
	ld.as r4,[gp,0x4e]
L_8e471e:
	mov_s r1,r13
L_8e4720:
	mov_s r2,0x0
L_8e4722:
	mov_s r3,r2
L_8e4724:
	mov_s r5,r2
L_8e4726:
	bl.d L_8e0c0c
L_8e472a:
	mov_s r6,r2
L_8e472c:
	st_s r0,[r13,0x20]
	.global L_8e472e
L_8e472e:
	b L_8c0254
L_8e4732:
	nop_s
