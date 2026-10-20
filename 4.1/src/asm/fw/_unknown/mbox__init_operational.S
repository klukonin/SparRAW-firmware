/* mbox__init_operational @ 0x8ded20, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sysassert__wmi_lock_notice
 * Зовёт сам: __ld_r13_ret, fw_mailbox__has_pending, mbox__ring_init, operational_if__mbox_ptr
 * Глобалы (через gp): 0x8003f0
 */
	.section .text.mbox__init_operational,"ax",@progbits
	.global mbox__init_operational
mbox__init_operational:
	.global L_8ded20
L_8ded20:
	push_s blink
L_8ded22:
	bl.d L_8d6e80
L_8ded26:
	push_s r13
L_8ded28:
	mov_s r13,r0
L_8ded2a:
	mov_s r0,0x1
L_8ded2c:
	st.as r0,[gp,0xa0]
L_8ded30:
	b_s L_8ded40
	.global L_8ded32
L_8ded32:
	bl.d L_8decf8
L_8ded36:
	mov_s r0,r13
L_8ded38:
	ld_s r0,[r13,0x44]
L_8ded3a:
	ld_s r1,[r0,0xc]
L_8ded3c:
	jl_s.d [r1]
L_8ded3e:
	mov_s r0,r13
	.global L_8ded40
L_8ded40:
	bl.d L_8c30bc
L_8ded44:
	mov_s r0,r13
L_8ded46:
	brne_s r0,0,L_8ded32
L_8ded48:
	ld_s r0,[r13,0x44]
L_8ded4a:
	ld_s r1,[r0,0x8]
L_8ded4c:
	jl_s.d [r1]
L_8ded4e:
	mov_s r0,r13
L_8ded50:
	mov_s r0,0x0
L_8ded52:
	b.d L_8c033c
L_8ded56:
	st.as r0,[gp,0xa0]
L_8ded5a:
	nop_s
