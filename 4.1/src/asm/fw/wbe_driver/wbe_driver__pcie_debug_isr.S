/* wbe_driver__pcie_debug_isr @ 0x8efa7c, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCIE DEBUG INTERRUPT port1_tx_fifo_pcpl_full_int (dbg_csu_lock=0x%X)
 *   wbe_driver.cpp
 *   PXE DEADLOCK: Disconnect
 * Зовут его: isr_pcie_debug
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_log__emit1, set_reg_88268c_x2_8f2930, set_reg_88269c_8ee7c0, sys__assert_no_error, u_schd__add, wbe_driver__pcie_debug
 * Глобалы (через gp): 0x800314
 */
	.section .text.wbe_driver__pcie_debug_isr,"ax",@progbits
	.global wbe_driver__pcie_debug_isr
wbe_driver__pcie_debug_isr:
	.global L_8efa7c
L_8efa7c:
	push_s blink
L_8efa7e:
	bl.d L_8ee7c0
L_8efa82:
	push_s r13
L_8efa84:
	mov_s r0,0x882e80
L_8efa8a:
	ld_s r13,[r0,0x5c]
L_8efa8c:
	mov_s r2,0x10039a8
L_8efa92:
	extb_s r13,r13
L_8efa94:
	mov_s r0,0xf
L_8efa96:
	mov_s r1,0x2
L_8efa98:
	bl.d L_8edfcc
L_8efa9c:
	mov_s r3,r13
L_8efa9e:
	breq_s r13,0,L_8efae0
L_8efaa0:
	ld_s r0,[gp,0x1a4]
L_8efaa2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8efaa4:
	bl.d L_8ef90c
L_8efaa8:
	st.as r0,[gp,0x69]
L_8efaac:
	mov_s r0,blink
L_8efaae:
	mov_s r2,0x10032e4
L_8efab4:
	mov_s r1,0xe5
L_8efab6:
	bset_s r1,r1,0xc
L_8efab8:
	bl.d L_8c8208
L_8efabc:
	mov r3,0x540
L_8efac0:
	mov_s r2,0x10039f0
L_8efac6:
	mov_s r0,0xf
L_8efac8:
	bl.d L_8edfb0
L_8efacc:
	mov_s r1,0x2
L_8eface:
	mov_s r0,0x2b448
L_8efad4:
	mov_s r1,0x1
L_8efad6:
	mov_s r2,0x0
L_8efad8:
	bl.d L_8c2ac8
L_8efadc:
	mov_s r3,0x2
L_8efade:
	b_s L_8efae4
	.global L_8efae0
L_8efae0:
	bl L_8f2930
	.global L_8efae4
L_8efae4:
	b L_8c033c
