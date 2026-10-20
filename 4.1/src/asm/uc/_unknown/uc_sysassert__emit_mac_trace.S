/* uc_sysassert__emit_mac_trace @ 0x92b7f8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_sysassert
 */
	.section .text.uc_sysassert__emit_mac_trace,"ax",@progbits
	.global uc_sysassert__emit_mac_trace
uc_sysassert__emit_mac_trace:
	.global L_92b7f8
L_92b7f8:
	push_s blink
L_92b7fa:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_92b7fc:
	bic r0,r0,-0x1f1
L_92b800:
	or r0,r0,0x3e000000
L_92b808:
	mov_s r32,r0
L_92b80a:
	st.ab r0,[r25,0x4]
L_92b80e:
	bclr r25,r25,0xa
L_92b812:
	mov_s r0,0x3d001000
L_92b818:
	mov_s r32,r0
L_92b81a:
	st.ab r0,[r25,0x4]
L_92b81e:
	bclr r25,r25,0xa
L_92b822:
	pop_s blink
L_92b824:
	j_s [blink]
L_92b826:
	nop_s
