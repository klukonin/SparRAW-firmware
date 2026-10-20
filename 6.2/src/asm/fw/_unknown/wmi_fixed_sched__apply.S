/* wmi_fixed_sched__apply @ 0x8c9854, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_enable_fixed_scheduling
 * Зовёт сам: __ld_r13_to_r13_ret, fixed_sched__start, fw_sysassert_fatal, hwd_dma__get_8812d8, vring__set_pair_mode
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_fixed_sched__apply
wmi_fixed_sched__apply:
	.global L_8c9854
L_8c9854:
	push_s blink
L_8c9856:
	push_s r13
L_8c9858:
	sub_s sp,sp,0x4
L_8c985a:
	mov_s r13,r1
L_8c985c:
	bl.d L_8d08a4
L_8c9860:
	mov_s r0,sp
L_8c9862:
	brne_s r0,0,L_8c9876
	.global L_8c9864
L_8c9864:
	bl.d L_8e72fc
L_8c9868:
	mov_s r0,0x1
L_8c986a:
	bl.d L_8c9884
L_8c986e:
	mov_s r0,r13
L_8c9870:
	b.d L_8c025c
L_8c9874:
	add_s sp,sp,0x4
	.global L_8c9876
L_8c9876:
	mov_s r0,blink
L_8c9878:
	mov_s r1,0x158b
L_8c987e:
	bl L_8c9b28
L_8c9882:
	b_s L_8c9864
