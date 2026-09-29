/* wbe_driver__pcie_debug_isr @ 0x8f7e5c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCIE DEBUG INTERRUPT port1_tx_fifo_pcpl_full_int (dbg_csu_lock=0x%X)
 *   PXE DEADLOCK: Disconnect
 * Зовут его: fw_vector_15
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit1, pcie_dbg__rearm_irq_bit3, pcie_debug__mask_tx_fifo_full_irq, u_schd__add, wbe_driver__pcie_debug
 * Глобалы (через gp): 0x800328
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wbe_driver__pcie_debug_isr
wbe_driver__pcie_debug_isr:
	.global L_8f7e5c
L_8f7e5c:
	push_s blink
L_8f7e5e:
	bl.d L_8f6b88
L_8f7e62:
	push_s r13
L_8f7e64:
	mov_s r0,0x882e80
L_8f7e6a:
	ld_s r13,[r0,0x5c]
L_8f7e6c:
	mov_s r1,0x10035e4
L_8f7e72:
	extb_s r13,r13
L_8f7e74:
	mov_s r0,0x2f
L_8f7e76:
	bl.d L_8dcc10
L_8f7e7a:
	mov_s r2,r13
L_8f7e7c:
	breq_s r13,0,L_8f7ea8
L_8f7e7e:
	ld_s r0,[gp,0x1a4]
L_8f7e80:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f7e82:
	bl.d L_8f7d20
L_8f7e86:
	st.as r0,[gp,0x69]
L_8f7e8a:
	mov_s r1,0x100362c
L_8f7e90:
	bl.d L_8dcba8
L_8f7e94:
	mov_s r0,0x2f
L_8f7e96:
	mov_s r0,L_8c91b8-0x8c0000
L_8f7e9c:
	mov_s r1,0x1
L_8f7e9e:
	mov_s r2,0x0
L_8f7ea0:
	bl.d L_8c3248
L_8f7ea4:
	mov_s r3,0x2
L_8f7ea6:
	b_s L_8f7eac
	.global L_8f7ea8
L_8f7ea8:
	bl L_8fa874
	.global L_8f7eac
L_8f7eac:
	b L_8c025c
