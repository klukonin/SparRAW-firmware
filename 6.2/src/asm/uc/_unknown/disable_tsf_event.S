/* disable_tsf_event @ 0x925a10, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   disable_tsf_event()
 * Зовут его: ucode_cmd_0x0b_handler
 * Зовёт сам: uc_log__emit_snapshot
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global disable_tsf_event
disable_tsf_event:
	.global L_925a10
L_925a10:
	push_s r13
L_925a12:
	mov_s r13,blink
L_925a14:
	mov r1,0x1000f90
L_925a1c:
	bl.d L_92d13c
L_925a20:
	mov r0,0x20
L_925a24:
	mov_s r2,0x887000
L_925a2a:
	st.as 0xc0010,[r2,-0xb2]
L_925a32:
	mov_s r0,0x40
L_925a34:
	bset_s r0,r0,0x19
L_925a36:
	mov_s r32,r0
L_925a38:
	st.ab r0,[r25,0x4]
L_925a3c:
	bclr r25,r25,0xa
L_925a40:
	mov_s blink,r13
L_925a42:
	j_s.d [blink]
L_925a44:
	pop_s r13
L_925a46:
	nop_s
