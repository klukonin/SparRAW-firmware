/* ps_mode_sm__init @ 0x8d596c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CONNECTION__assoc_ntf
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__setup
 * Глобалы (через gp): 0x8001a0, 0x80040c
 */
	.section .text.ps_mode_sm__init,"ax",@progbits
	.global ps_mode_sm__init
ps_mode_sm__init:
	.global L_8d596c
L_8d596c:
	push_s blink
L_8d596e:
	bl.d L_8c02bc
L_8d5972:
	mov r6,0x6
L_8d5976:
	mov_s r13,r0
L_8d5978:
	mov_s r14,r1
L_8d597a:
	mov_s r15,r2
L_8d597c:
	mov r4,0x800a74
L_8d5984:
	mov r5,0x800a8c
L_8d598c:
	ld.as r1,[gp,0xc]
L_8d5990:
	mov_s r2,0x0
L_8d5992:
	mov_s r16,r2
L_8d5994:
	mov_s r3,0x801a0c
L_8d599a:
	bl.d L_8d6478
L_8d599e:
	mov r7,0x8
L_8d59a2:
	ld_s r0,[gp,0x29c]
L_8d59a4:
	st_s r14,[r13,0x2c]
L_8d59a6:
	stw_s r15,[r13,0x30]
L_8d59a8:
	brne_s r0,0,L_8d59b0
L_8d59aa:
	st r16,[r13, 0x28]
L_8d59ae:
	b_s L_8d59b4
	.global L_8d59b0
L_8d59b0:
	mov_s r0,0x1
L_8d59b2:
	st_s r0,[r13,0x28]
	.global L_8d59b4
L_8d59b4:
	b L_8c0324
