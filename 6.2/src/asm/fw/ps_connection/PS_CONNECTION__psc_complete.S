/* PS_CONNECTION__psc_complete @ 0x8e172c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcp_psc_sm__psc_done, sta_psc_sm__psc_done_sm
 * Зовёт сам: PS_CONNECTION__psc_complete_8e1794
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global PS_CONNECTION__psc_complete
PS_CONNECTION__psc_complete:
	.global L_8e172c
L_8e172c:
	mov_s r6,r1
L_8e172e:
	mov_s r5,r2
L_8e1730:
	ld_s r1,[r0,0x4c]
L_8e1732:
	mov_s r4,r3
L_8e1734:
	cmp_s r1,0x0
L_8e1736:
	mov_s r1,0x1
L_8e1738:
	sub_s.ne r1,r1,r1
L_8e173a:
	ld_s r0,[r0,0x48]
L_8e173c:
	mov_s r2,r6
L_8e173e:
	b.d L_8e17cc
L_8e1742:
	mov_s r3,r5
