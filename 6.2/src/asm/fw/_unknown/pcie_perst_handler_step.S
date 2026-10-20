/* pcie_perst_handler_step @ 0x8f0d28, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_16
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_pcie__is_ep_under_serdes, hwd_pcie__read_8825c0, mlme_sm__assoc_req_handle
 * Глобалы (через gp): 0x80037c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_perst_handler_step
pcie_perst_handler_step:
	.global L_8f0d28
L_8f0d28:
	push_s blink
L_8f0d2a:
	bl.d L_8d141c
L_8f0d2e:
	push_s r13
L_8f0d30:
	mov_s r13,r0
L_8f0d32:
	ld_s r0,[gp,0x1f8]
L_8f0d34:
	breq r0,0x0,L_8f0dce
L_8f0d38:
	bl L_8d1470
L_8f0d3c:
	cmp_s r0,0x0
L_8f0d3e:
	btst.eq r13,0x1
L_8f0d42:
	sub_s.ne r0,r0,r0
L_8f0d44:
	mov.ne r1,0x1
L_8f0d48:
	mov.ne r2,r0
L_8f0d4c:
	mov.ne r3,r0
L_8f0d50:
	mov.ne r4,0x10
L_8f0d54:
	mov.ne r6,0x200000
L_8f0d5c:
	bl.ne.d L_8f0e14
L_8f0d60:
	mov.ne r5,0x4
L_8f0d64:
	bbit0 r13,0x2,L_8f0d9a
L_8f0d68:
	mov_s r0,0x0
L_8f0d6a:
	mov_s r1,r0
L_8f0d6c:
	mov_s r2,0x1
L_8f0d6e:
	mov_s r3,r0
L_8f0d70:
	mov r4,0x10
L_8f0d74:
	mov r6,0x800000
L_8f0d7c:
	bl.d L_8f0e14
L_8f0d80:
	mov r5,0x8
L_8f0d84:
	mov_s r0,0x0
L_8f0d86:
	mov_s r1,r0
L_8f0d88:
	mov_s r2,0x1
L_8f0d8a:
	mov_s r3,r0
L_8f0d8c:
	mov r4,0x14
L_8f0d90:
	mov_s r5,r2
L_8f0d92:
	bl.d L_8f0e14
L_8f0d96:
	mov r6,0x100
	.global L_8f0d9a
L_8f0d9a:
	bbit0 r13,0x3,L_8f0dce
L_8f0d9e:
	mov_s r0,0x0
L_8f0da0:
	mov_s r1,r0
L_8f0da2:
	mov_s r2,0x1
L_8f0da4:
	mov_s r3,r2
L_8f0da6:
	mov r4,0x10
L_8f0daa:
	mov r6,0x800000
L_8f0db2:
	bl.d L_8f0e14
L_8f0db6:
	mov_s r5,r0
L_8f0db8:
	mov_s r0,0x0
L_8f0dba:
	mov_s r1,r0
L_8f0dbc:
	mov_s r2,0x1
L_8f0dbe:
	mov_s r3,r2
L_8f0dc0:
	mov r4,0x14
L_8f0dc4:
	mov_s r5,r2
L_8f0dc6:
	bl.d L_8f0e14
L_8f0dca:
	mov r6,0x100
	.global L_8f0dce
L_8f0dce:
	b L_8c025c
L_8f0dd2:
	nop_s
