/* debug_mbox__get_or_init @ 0x8d9f9c, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Debug MBOX init
 * Зовут его: fw_main, lmac_if__echo_evt_body, lmac_if__echo_pair, mbox__drain_debug, sysassert__wmi_lock_notice
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, mbox__init_descriptor
 * Глобалы (через gp): 0x80032c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global debug_mbox__get_or_init
debug_mbox__get_or_init:
	.global L_8d9f9c
L_8d9f9c:
	push_s blink
L_8d9f9e:
	push_s r13
L_8d9fa0:
	sub_s sp,sp,0x10
L_8d9fa2:
	mov_s r1,0x1003a80
L_8d9fa8:
	bl.d L_8dcba8
L_8d9fac:
	mov_s r0,0x20
L_8d9fae:
	ld_s r0,[gp,-0xb0]
L_8d9fb0:
	mov_s r13,0x843040
L_8d9fb6:
	brne_s r0,0,L_8da002
L_8d9fb8:
	mov_s r0,0x0
L_8d9fba:
	st.as r0,[gp,0x6a]
L_8d9fbe:
	mov_s r3,0x88042c
L_8d9fc4:
	mov_s r0,0x4
L_8d9fc6:
	st_s r0,[sp,0x0]
L_8d9fc8:
	mov_s r0,0x7
L_8d9fca:
	st_s r0,[sp,0x4]
L_8d9fcc:
	mov_s r0,0x64
L_8d9fce:
	st_s r0,[sp,0x8]
L_8d9fd0:
	mov r0,0x100
L_8d9fd4:
	st_s r0,[sp,0xc]
L_8d9fd6:
	mov_s r0,r13
L_8d9fd8:
	sub2 r1,r3,0x11
L_8d9fdc:
	sub r2,r3,0x18
L_8d9fe0:
	mov r4,0x846fac
L_8d9fe8:
	mov r5,0x84713c
L_8d9ff0:
	mov r6,0x2
L_8d9ff4:
	bl.d L_8f942c
L_8d9ff8:
	mov r7,0x5
L_8d9ffc:
	mov_s r0,0x1
L_8d9ffe:
	st.as r0,[gp,-0x2c]
	.global L_8da002
L_8da002:
	mov_s r0,r13
L_8da004:
	b.d L_8c025c
L_8da008:
	add_s sp,sp,0x10
L_8da00a:
	nop_s
