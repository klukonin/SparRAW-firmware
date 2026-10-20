/* get_g_801488_8d7464 @ 0x8d7464, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__reset_queue_0x19, dma_mgr__reset_queue_0x1a
 */
	.section .text.get_g_801488_8d7464,"ax",@progbits
	.global get_g_801488_8d7464
get_g_801488_8d7464:
	.global L_8d7464
L_8d7464:
	brhs r0,0x20,L_8d747a
L_8d7468:
	mov_s r1,0x801488
L_8d746e:
	add3_s r1,r1,r0
L_8d7470:
	ld_s r0,[r1,0x4]
L_8d7472:
	cmp_s r0,0x1
L_8d7474:
	mov_s r0,0x1
L_8d7476:
	sub_s.ne r0,r0,r0
L_8d7478:
	b_s L_8d747c
	.global L_8d747a
L_8d747a:
	mov_s r0,0x0
	.global L_8d747c
L_8d747c:
	j_s [blink]
L_8d747e:
	nop_s
