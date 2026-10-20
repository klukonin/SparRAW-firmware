/* peer_masks__or_sta_bit_into_8571c4 @ 0x921c34, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__abort_step
 * Глобалы (через gp): 0x800570
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global peer_masks__or_sta_bit_into_8571c4
peer_masks__or_sta_bit_into_8571c4:
	.global L_921c34
L_921c34:
	mov_s r2,0x0
L_921c36:
	ld.as r1,[gp,0x12]
L_921c3a:
	bset r2,r2,r0
L_921c3e:
	and_s r1,r1,r2
L_921c40:
	mov_s r2,0x857180
L_921c46:
	ld_s r0,[r2,0x44]
L_921c48:
	or_s r0,r0,r1
L_921c4a:
	j_s.d [blink]
L_921c4c:
	st_s r0,[r2,0x44]
L_921c4e:
	nop_s
