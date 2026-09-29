/* ftm_state_sm__init @ 0x8f52a4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tof__init
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__bind_descriptor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm_state_sm__init
ftm_state_sm__init:
	.global L_8f52a4
L_8f52a4:
	push_s blink
L_8f52a6:
	push_s r13
L_8f52a8:
	mov_s r1,0x8034c0
L_8f52ae:
	bl.d L_8d94e0
L_8f52b2:
	mov_s r13,r0
L_8f52b4:
	mov_s r0,0x4
L_8f52b6:
	b.d L_8c025c
L_8f52ba:
	st_s r0,[r13,0x18]
