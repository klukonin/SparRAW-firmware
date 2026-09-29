/* sta_link__byte_by_index @ 0x9300c0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__flow_exit, sta__apply_bf_result, sta__reset_link_state
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sta_link__byte_by_index
sta_link__byte_by_index:
	.global L_9300c0
L_9300c0:
	mov_s r1,0x8027ed
L_9300c6:
	mul64 r0,0x26
L_9300ca:
	j_s.d [blink]
L_9300cc:
	ldb r0,[r1,mlo]
