/* get_g_801488_8d7480 @ 0x8d7480, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__reset_queue_0x19, dma_mgr__reset_queue_0x1a
 */
	.section .text.get_g_801488_8d7480,"ax",@progbits
	.global get_g_801488_8d7480
get_g_801488_8d7480:
	.global L_8d7480
L_8d7480:
	brhs r0,0x20,L_8d7496
L_8d7484:
	mov_s r1,0x801488
L_8d748a:
	add3_s r1,r1,r0
L_8d748c:
	ld_s r0,[r1,0x4]
L_8d748e:
	cmp_s r0,0x0
L_8d7490:
	mov_s r0,0x1
L_8d7492:
	sub_s.ne r0,r0,r0
L_8d7494:
	b_s L_8d7498
	.global L_8d7496
L_8d7496:
	mov_s r0,0x0
	.global L_8d7498
L_8d7498:
	j_s [blink]
L_8d749a:
	nop_s
