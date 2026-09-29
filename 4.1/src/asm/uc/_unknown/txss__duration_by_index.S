/* txss__duration_by_index @ 0x926450, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss__flow_body
 */
	.section .text.txss__duration_by_index,"ax",@progbits
	.global txss__duration_by_index
txss__duration_by_index:
	.global L_926450
L_926450:
	brhs r0,0x6,L_926484
L_926454:
	ldb.x r0,[0x800bbc,r0]
L_92645c:
	add r2,pcl,0x8
L_926460:
	add1_s r2,r2,r0
L_926462:
	j_s [r2]
L_926464:
	mov_s r0,0x2e26
L_92646a:
	j_s [blink]
L_92646c:
	mov_s r0,0x5724
L_926472:
	j_s [blink]
L_926474:
	mov_s r0,0xa920
L_92647a:
	j_s [blink]
L_92647c:
	mov_s r0,0x14d18
L_926482:
	j_s [blink]
	.global L_926484
L_926484:
	mov_s r0,0x800f74
L_92648a:
	ld.as r0,[r0,r1]
L_92648e:
	j_s [blink]
