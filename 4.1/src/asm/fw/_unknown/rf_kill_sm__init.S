/* rf_kill_sm__init @ 0x8ecf84, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Initializing RF_KILL_SM with W_DISABLE
 * Зовут его: l2mgr__on_lmac_ready
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, basic_sm__setup, fw_log__emit0, rgf_reg_880280_8ea634, set_reg_880b00_8c0744, set_reg_880b00_8c1480, set_reg_880b00_8c15d0
 * Глобалы (через gp): 0x8001ac
 */
	.section .text.rf_kill_sm__init,"ax",@progbits
	.global rf_kill_sm__init
rf_kill_sm__init:
	.global L_8ecf84
L_8ecf84:
	push_s blink
L_8ecf86:
	push_s r13
L_8ecf88:
	mov_s r13,r0
L_8ecf8a:
	mov r4,0x800f4c
L_8ecf92:
	mov r5,0x800f5c
L_8ecf9a:
	ld.as r1,[gp,0xf]
L_8ecf9e:
	mov_s r2,0x0
L_8ecfa0:
	mov_s r3,0x801e10
L_8ecfa6:
	mov r6,0x4
L_8ecfaa:
	bl.d L_8d6478
L_8ecfae:
	mov r7,0x3
L_8ecfb2:
	mov_s r0,0x880a3c
L_8ecfb8:
	ld_s r0,[r0,0x58]
L_8ecfba:
	bbit0 r0,0x0,L_8ecff6
L_8ecfbe:
	bl.d L_8ea634
L_8ecfc2:
	mov_s r0,r13
L_8ecfc4:
	mov_s r0,0x880280
L_8ecfca:
	ld_s r0,[r0,0x8]
L_8ecfcc:
	bbit1 r0,0x0,L_8ecfec
L_8ecfd0:
	mov_s r2,0x100a4e8
L_8ecfd6:
	mov_s r0,0x0
L_8ecfd8:
	bl.d L_8edfb0
L_8ecfdc:
	mov_s r1,0x2
L_8ecfde:
	mov_s r0,r13
L_8ecfe0:
	mov_s r1,0x1
L_8ecfe2:
	mov_s r2,0x0
L_8ecfe4:
	mov_s r3,r2
L_8ecfe6:
	bl.d L_8d6a1c
L_8ecfea:
	mov_s r4,r2
	.global L_8ecfec
L_8ecfec:
	bl L_8c0744
L_8ecff0:
	bl L_8c15d0
L_8ecff4:
	b_s L_8ecffa
	.global L_8ecff6
L_8ecff6:
	bl L_8c1480
	.global L_8ecffa
L_8ecffa:
	b L_8c033c
L_8ecffe:
	nop_s
