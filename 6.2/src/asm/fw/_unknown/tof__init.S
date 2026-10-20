/* tof__init @ 0x8d940c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [TOF] Init.
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r13_to_r13_ret, ftm_state_sm__init, fw_log_emit0, mem_pool__init, tof__init_session_defaults
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tof__init
tof__init:
	.global L_8d940c
L_8d940c:
	push_s blink
L_8d940e:
	push_s r13
L_8d9410:
	mov_s r1,0x1019790
L_8d9416:
	bl.d L_8dcba8
L_8d941a:
	mov_s r0,0x2b
L_8d941c:
	mov_s r13,0x806518
L_8d9422:
	mov_s r1,0x806550
L_8d9428:
	add r0,r13,0x24
L_8d942c:
	mov_s r2,0x20
L_8d942e:
	bl.d L_8c7cf8
L_8d9432:
	mov_s r3,0x8
L_8d9434:
	bl.d L_8f52a4
L_8d9438:
	mov_s r0,r13
L_8d943a:
	mov_s r3,0x806650
L_8d9440:
	bl.d L_8e64bc
L_8d9444:
	mov_s r0,r3
L_8d9446:
	b.d L_8c025c
L_8d944a:
	mov_s r0,r3
