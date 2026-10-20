/* uc_sysassert__emit_mac_trace @ 0x92f2f0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_sysassert__emit_mac_trace
uc_sysassert__emit_mac_trace:
	.global L_92f2f0
L_92f2f0:
	push_s blink
L_92f2f2:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_92f2f4:
	bic r0,r0,-0x1f1
L_92f2f8:
	or r0,r0,0x3e000000
L_92f300:
	mov_s r32,r0
L_92f302:
	st.ab r0,[r25,0x4]
L_92f306:
	bclr r25,r25,0xa
L_92f30a:
	mov_s r0,0x3d001000
L_92f310:
	mov_s r32,r0
L_92f312:
	st.ab r0,[r25,0x4]
L_92f316:
	bclr r25,r25,0xa
L_92f31a:
	pop_s blink
L_92f31c:
	j_s [blink]
L_92f31e:
	nop_s
