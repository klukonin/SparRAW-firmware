/* rx_api__free_rx_buffer @ 0x8c9428, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/rx_api.h
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, mem_pool__free_8062c4
 */
	.section .text.rx_api__free_rx_buffer,"ax",@progbits
	.global rx_api__free_rx_buffer
rx_api__free_rx_buffer:
L_8c9428:
	push_s blink
L_8c942a:
	bl L_8c02c4
L_8c942e:
	mov.f r13,r0
L_8c9432:
	sub_s sp,sp,0xc
L_8c9434:
	mov_s r14,sp
L_8c9436:
	beq_s L_8c9452
	.global L_8c9438
L_8c9438:
	st_s r13,[r14,0x8]
L_8c943a:
	add r0,r13,0x10
L_8c943e:
	st_s r0,[r14,0x4]
L_8c9440:
	sub r13,r13,0x28
L_8c9444:
	st_s r13,[r14]
L_8c9446:
	bl.d L_8c9578
L_8c944a:
	ld_s r0,[sp,0x0]
L_8c944c:
	b.d L_8c0334
L_8c9450:
	add_s sp,sp,0xc
	.global L_8c9452
L_8c9452:
	mov_s r0,blink
L_8c9454:
	mov_s r2,0x10152d0
L_8c945a:
	mov_s r1,0x3
L_8c945c:
	bset_s r1,r1,0xc
L_8c945e:
	bl.d L_8c82c0
L_8c9462:
	mov_s r3,0x39
L_8c9464:
	b_s L_8c9438
L_8c9466:
	nop_s
