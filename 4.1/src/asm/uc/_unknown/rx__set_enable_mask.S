/* rx__set_enable_mask @ 0x921f84, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_bi_trigger_step, rx_funcs__set_rx_off, ucode_cmd__rx_on
 * Глобалы (через gp): 0x800588
 */
	.section .text.rx__set_enable_mask,"ax",@progbits
	.global rx__set_enable_mask
rx__set_enable_mask:
	.global L_921f84
L_921f84:
	lr r1,[0xa]
L_921f88:
	bclr r2,r1,0x1
L_921f8c:
	flag r2
L_921f90:
	cmp_s r0,0x0
L_921f92:
	mov_s r0,0x1c
L_921f94:
	mov.eq r0,0xffffffff
L_921f9c:
	st.as r0,[gp,0x18]
L_921fa0:
	lr r0,[0xa]
L_921fa4:
	bic r1,r1,-0x3
L_921fa8:
	or_s r1,r1,r0
L_921faa:
	flag r1
L_921fae:
	j_s [blink]
