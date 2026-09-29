/* vring__set_pair_mode @ 0x8e72fc, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_fixed_sched__apply
 * Зовёт сам: __ld_r13_to_r13_ret, vring__clear_pair_words, vring__reset_pair, vring__reset_pair_b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__set_pair_mode
vring__set_pair_mode:
	.global L_8e72fc
L_8e72fc:
	push_s blink
L_8e72fe:
	push_s r13
L_8e7300:
	ld.as r1,[gp,-0x46]
L_8e7304:
	breq r0,r1,L_8e732e
L_8e7308:
	st.as r0,[gp,-0x46]
L_8e730c:
	mov_s r1,0x804dbc
L_8e7312:
	cmp_s r0,0x1
L_8e7314:
	mov_s r13,0x804e64
L_8e731a:
	mov_s r0,r1
L_8e731c:
	bne_s L_8e732a
L_8e731e:
	bl L_8c8f68
L_8e7322:
	bl.d L_8c984c
L_8e7326:
	mov_s r0,r13
L_8e7328:
	b_s L_8e732e
	.global L_8e732a
L_8e732a:
	bl L_8c9830
	.global L_8e732e
L_8e732e:
	b L_8c025c
L_8e7332:
	nop_s
