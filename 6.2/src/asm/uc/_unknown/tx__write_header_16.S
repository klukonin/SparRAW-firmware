/* tx__write_header_16 @ 0x939a64, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm4
 * Зовёт сам: __ld_r13_to_r13_ret, direct_tx__program_cmd34, direct_tx__send_after_delay, mac__program_tx_with_rate
 * Глобалы (через gp): 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx__write_header_16
tx__write_header_16:
	.global L_939a64
L_939a64:
	push_s blink
L_939a66:
	push_s r13
L_939a68:
	mov_s r13,r0
L_939a6a:
	mov_s r0,0x10
L_939a6c:
	bl.d L_9257a8
L_939a70:
	mov_s r1,r0
L_939a72:
	bl.d L_92d8e8
L_939a76:
	mov_s r0,0x0
	.global L_939a78
L_939a78:
	mov_s r0,r43
L_939a7a:
	bbit0 r0,0x1f,L_939a78
L_939a7e:
	mov_s r0,r51
L_939a80:
	bmsk r1,r0,0x3
L_939a84:
	st.as r1,[gp,0x38]
L_939a88:
	lsr_s r0,r0,0x4
L_939a8a:
	st.as r0,[gp,0x39]
	.global L_939a8e
L_939a8e:
	mov_s r0,r45
L_939a90:
	bbit0 r0,0x1f,L_939a8e
L_939a94:
	mov_s r0,r13
L_939a96:
	mov_s r1,0xb
L_939a98:
	bl.d L_938218
L_939a9c:
	mov_s r2,0x0
L_939a9e:
	b L_9202ac
L_939aa2:
	nop_s
