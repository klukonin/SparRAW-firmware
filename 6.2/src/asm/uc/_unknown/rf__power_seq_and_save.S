/* rf__power_seq_and_save @ 0x93c888, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode__switch_sequence
 * Зовёт сам: __ld_r13_to_r13_ret, hw__power_sequence_rf, mac__set_mode_a000
 * Глобалы (через gp): 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rf__power_seq_and_save
rf__power_seq_and_save:
	.global L_93c888
L_93c888:
	push_s blink
L_93c88a:
	push_s r13
L_93c88c:
	mov.f r13,r0
L_93c890:
	beq_s L_93c898
L_93c892:
	bl L_92a754
L_93c896:
	b_s L_93c8bc
	.global L_93c898
L_93c898:
	mov_s r0,0x3d000004
L_93c89e:
	mov_s r32,r0
L_93c8a0:
	st.ab r0,[r25,0x4]
L_93c8a4:
	bclr r25,r25,0xa
L_93c8a8:
	nop_s
L_93c8aa:
	nop_s
L_93c8ac:
	nop_s
L_93c8ae:
	mov_s r0,0x41
L_93c8b0:
	asl_s r0,r0,0x13
L_93c8b2:
	mov_s r32,r0
L_93c8b4:
	st.ab r0,[r25,0x4]
L_93c8b8:
	bclr r25,r25,0xa
	.global L_93c8bc
L_93c8bc:
	mov_s r1,0x8014d8
L_93c8c2:
	mov_s r0,r13
L_93c8c4:
	mov_s r2,0x0
L_93c8c6:
	mov_s r3,r2
L_93c8c8:
	bl.d L_92ab40
L_93c8cc:
	mov_s r4,r2
L_93c8ce:
	mov_s r0,0x889480
L_93c8d4:
	ld_s r0,[r0,0x8]
L_93c8d6:
	b.d L_9202ac
L_93c8da:
	st.as r0,[gp,0x5e]
L_93c8de:
	nop_s
