/* l2mgr__init_radio_mgr @ 0x8ed4a0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init, l2mgr__init
 * Зовёт сам: __ld_r13_ret, radio_mgr__init_pool_and_sm
 */
	.section .text.l2mgr__init_radio_mgr,"ax",@progbits
	.global l2mgr__init_radio_mgr
l2mgr__init_radio_mgr:
	.global L_8ed4a0
L_8ed4a0:
	push_s blink
L_8ed4a2:
	push_s r13
L_8ed4a4:
	mov_s r13,0x8063f4
L_8ed4aa:
	bl.d L_8d5c0c
L_8ed4ae:
	mov_s r0,r13
L_8ed4b0:
	b.d L_8c033c
L_8ed4b4:
	st.as r13,[gp,-0xc]
