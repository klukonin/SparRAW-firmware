/* mcs__is_restricted @ 0x8da568, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: maintain_sm__config_mcs_en_vec
 * Глобалы (через gp): 0x800214
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mcs__is_restricted
mcs__is_restricted:
	.global L_8da568
L_8da568:
	ld_s r0,[gp,-0xc4]
L_8da56a:
	mov_s r1,0x0
L_8da56c:
	brne_s r0,0,L_8da578
L_8da56e:
	ldw_s r0,[gp,0x90]
L_8da570:
	brne r0,0x4a50,L_8da57c
	.global L_8da578
L_8da578:
	mov_s r0,r1
L_8da57a:
	b_s L_8da57e
	.global L_8da57c
L_8da57c:
	mov_s r0,0x1
	.global L_8da57e
L_8da57e:
	j_s.d [blink]
L_8da580:
	extb_s r0,r0
L_8da582:
	nop_s
