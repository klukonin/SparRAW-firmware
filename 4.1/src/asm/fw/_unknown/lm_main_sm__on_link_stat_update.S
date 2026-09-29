/* lm_main_sm__on_link_stat_update @ 0x8d7ac0, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.lm_main_sm__on_link_stat_update,"ax",@progbits
	.global lm_main_sm__on_link_stat_update
lm_main_sm__on_link_stat_update:
L_8d7ac0:
	ld.as r2,[r0,0x41]
L_8d7ac4:
	breq r1,r2,L_8d7adc
L_8d7ac8:
	mov_s r2,0x80345c
L_8d7ace:
	ld_s r2,[r2,0x18]
L_8d7ad0:
	btst_s r2,0x2
L_8d7ad2:
	btst.eq r2,0x1
L_8d7ad6:
	bne_s L_8d7adc
L_8d7ad8:
	st.as r1,[r0,0x41]
	.global L_8d7adc
L_8d7adc:
	j_s [blink]
L_8d7ade:
	nop_s
