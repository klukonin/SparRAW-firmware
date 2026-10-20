/* rm_ch_switch__resume_tx_queue @ 0x8e7948, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_ch_switch_sm__switch_on
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fwq_tx__enable_queue
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_ch_switch__resume_tx_queue
rm_ch_switch__resume_tx_queue:
	.global L_8e7948
L_8e7948:
	push_s blink
L_8e794a:
	bl L_8c01e4
L_8e794e:
	mov_s r13,r0
L_8e7950:
	mov_s r14,0x842154
L_8e7956:
	mov_s r0,r14
L_8e7958:
	bl.d L_8e787c
L_8e795c:
	mov_s r1,r13
L_8e795e:
	mov_s r0,0x842274
L_8e7964:
	bl.d L_8e787c
L_8e7968:
	mov_s r1,r13
L_8e796a:
	add3 r0,r14,0x12
L_8e796e:
	bl.d L_8e787c
L_8e7972:
	mov_s r1,r13
L_8e7974:
	b L_8c0254
