/* mbox__init_debug @ 0x8ded5c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sysassert__wmi_lock_notice
 * Зовёт сам: __ld_r13_ret, fw_mailbox__has_pending, mbox__debug_init_flow, mbox__ring_init
 * Глобалы (через gp): 0x800320
 */
	.section .text.mbox__init_debug,"ax",@progbits
	.global mbox__init_debug
mbox__init_debug:
	.global L_8ded5c
L_8ded5c:
	push_s blink
L_8ded5e:
	bl.d L_8d6ea8
L_8ded62:
	push_s r13
L_8ded64:
	mov_s r13,r0
L_8ded66:
	mov_s r0,0x1
L_8ded68:
	st.as r0,[gp,0x6c]
L_8ded6c:
	b_s L_8ded74
	.global L_8ded6e
L_8ded6e:
	bl.d L_8decf8
L_8ded72:
	mov_s r0,r13
	.global L_8ded74
L_8ded74:
	bl.d L_8c30bc
L_8ded78:
	mov_s r0,r13
L_8ded7a:
	brne_s r0,0,L_8ded6e
L_8ded7c:
	ld_s r0,[r13,0x44]
L_8ded7e:
	ld_s r1,[r0,0x8]
L_8ded80:
	jl_s.d [r1]
L_8ded82:
	mov_s r0,r13
L_8ded84:
	mov_s r0,0x0
L_8ded86:
	b.d L_8c033c
L_8ded8a:
	st.as r0,[gp,0x6c]
L_8ded8e:
	nop_s
