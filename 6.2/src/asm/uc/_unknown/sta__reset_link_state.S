/* sta__reset_link_state @ 0x921900, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__process_request_fifo, sta__apply_bf_result
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, memset0_words_uc, rs_abort, sta_link__byte_by_index
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sta__reset_link_state
sta__reset_link_state:
	.global L_921900
L_921900:
	push_s blink
L_921902:
	bl L_920230
L_921906:
	mov_s r15,r0
L_921908:
	mov_s r14,r1
L_92190a:
	mov_s r13,r2
L_92190c:
	mov_s r0,gp
L_92190e:
	add r0,r0,0xd4
L_921912:
	bl.d L_920a84
L_921916:
	mov_s r1,0x3
L_921918:
	breq_s r14,0,L_92192a
L_92191a:
	mov_s r2,0x0
L_92191c:
	asl_s r0,r15,0x2
L_92191e:
	add2_s r0,r0,r0
L_921920:
	add r1,r0,0x857e49
L_921928:
	stb_s r2,[r1]
	.global L_92192a
L_92192a:
	breq_s r13,0,L_92193c
L_92192c:
	bl.d L_9300c0
L_921930:
	mov_s r0,r15
L_921932:
	cmp_s r0,0x0
L_921934:
	bl.eq.d L_92fb80
L_921938:
	mov.eq r0,r15
	.global L_92193c
L_92193c:
	b L_92029c
