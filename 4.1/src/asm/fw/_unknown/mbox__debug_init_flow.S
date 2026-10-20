/* mbox__debug_init_flow @ 0x8d6ea8, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Debug MBOX init
 * Зовут его: WBE_DRIVER__pcie_boot_init, lmac_echo__alloc_mbox_slot, lmac_echo__report_to_host, mbox__init_debug, sysassert__wmi_lock_notice
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, mbox__build_rings_and_pool
 * Глобалы (через gp): 0x80031c
 */
	.section .text.mbox__debug_init_flow,"ax",@progbits
	.global mbox__debug_init_flow
mbox__debug_init_flow:
	.global L_8d6ea8
L_8d6ea8:
	push_s blink
L_8d6eaa:
	bl.d L_8c02c4
L_8d6eae:
	mov_s r1,0x2
L_8d6eb0:
	sub_s sp,sp,0x10
L_8d6eb2:
	mov_s r2,0x1003e40
L_8d6eb8:
	mov_s r13,0x0
L_8d6eba:
	bl.d L_8edfb0
L_8d6ebe:
	mov_s r0,r13
L_8d6ec0:
	ld_s r0,[gp,-0xa0]
L_8d6ec2:
	mov_s r14,0x843040
L_8d6ec8:
	brne_s r0,0,L_8d6f12
L_8d6eca:
	st.as r13,[gp,0x6b]
L_8d6ece:
	mov_s r3,0x88047c
L_8d6ed4:
	mov_s r0,0x4
L_8d6ed6:
	st_s r0,[sp,0x0]
L_8d6ed8:
	mov_s r0,0x7
L_8d6eda:
	st_s r0,[sp,0x4]
L_8d6edc:
	mov_s r0,0x64
L_8d6ede:
	st_s r0,[sp,0x8]
L_8d6ee0:
	mov r0,0x100
L_8d6ee4:
	st_s r0,[sp,0xc]
L_8d6ee6:
	mov_s r0,r14
L_8d6ee8:
	sub2 r1,r3,0x11
L_8d6eec:
	sub r2,r3,0x18
L_8d6ef0:
	mov r4,0x84754c
L_8d6ef8:
	mov r5,0x8476dc
L_8d6f00:
	mov r6,0x2
L_8d6f04:
	bl.d L_8f1104
L_8d6f08:
	mov r7,0x5
L_8d6f0c:
	mov_s r0,0x1
L_8d6f0e:
	st.as r0,[gp,-0x28]
	.global L_8d6f12
L_8d6f12:
	mov_s r0,r14
L_8d6f14:
	b.d L_8c0334
L_8d6f18:
	add_s sp,sp,0x10
L_8d6f1a:
	nop_s
