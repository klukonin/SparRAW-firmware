/* pcp_psc_sm__init @ 0x8d5924, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: psc_if__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__setup
 * Глобалы (через gp): 0x8001a8, 0x80040c
 */
	.section .text.pcp_psc_sm__init,"ax",@progbits
	.global pcp_psc_sm__init
pcp_psc_sm__init:
	.global L_8d5924
L_8d5924:
	push_s blink
L_8d5926:
	bl.d L_8c02c4
L_8d592a:
	mov r6,0x6
L_8d592e:
	mov_s r13,r0
L_8d5930:
	st_s r1,[r0,0x34]
L_8d5932:
	mov_s r14,0x0
L_8d5934:
	st_s r14,[r0,0x2c]
L_8d5936:
	mov r4,0x800ac8
L_8d593e:
	ld.as r1,[gp,0xe]
L_8d5942:
	mov_s r2,r14
L_8d5944:
	mov_s r3,0x801b4c
L_8d594a:
	mov r5,0x80048c
L_8d5952:
	bl.d L_8d6478
L_8d5956:
	mov r7,0x2
L_8d595a:
	ld_s r0,[gp,0x29c]
L_8d595c:
	breq_s r0,0,L_8d5964
L_8d595e:
	mov_s r0,0x1
L_8d5960:
	st_s r0,[r13,0x28]
L_8d5962:
	b_s L_8d5966
	.global L_8d5964
L_8d5964:
	st_s r14,[r13,0x28]
	.global L_8d5966
L_8d5966:
	b L_8c0334
L_8d596a:
	nop_s
