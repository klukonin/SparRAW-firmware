/* POWER_MNGR__init @ 0x8d580c, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   POWER_MNGR:: m_ps_if_ptr: %x m_ps_nonassoc_mgr: %x
 *   POWER_MNGR::init  External clock (33KHz) was detected!!!
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit2, hwm_power_33kHz_clk_detector, pcie_device_power_if__init, power_mngr__load_defaults, ps_assoc_mgr__vt04, ps_nonassoc_mgr__vt04, stub_ret_8ca000
 * Глобалы (через gp): 0x8001ee, 0x8002f4
 */
	.section .text.POWER_MNGR__init,"ax",@progbits
	.global POWER_MNGR__init
POWER_MNGR__init:
	.global L_8d580c
L_8d580c:
	push_s blink
L_8d580e:
	bl L_8c02c4
L_8d5812:
	mov_s r13,0x803510
L_8d5818:
	bl.d L_8d5d2c
L_8d581c:
	add3 r0,r13,0xd
L_8d5820:
	bl.d L_8d6028
L_8d5824:
	mov_s r0,r13
L_8d5826:
	bl.d L_8d5b68
L_8d582a:
	add r0,r13,0x2c
L_8d582e:
	bl.d L_8d5b80
L_8d5832:
	mov_s r14,0x0
L_8d5834:
	add3 r0,r13,0xd
L_8d5838:
	st.as r0,[gp,-0x16]
L_8d583c:
	mov_s r2,0x1001eb8
L_8d5842:
	mov_s r0,r14
L_8d5844:
	mov_s r1,0x2
L_8d5846:
	add3 r3,r13,0xd
L_8d584a:
	bl.d L_8edff8
L_8d584e:
	add3 r4,r13,0xd
L_8d5852:
	stb r14,[gp, 0xc6]
L_8d5856:
	st.as r14,[gp,-0xa]
L_8d585a:
	bl.d L_8d4cc0
L_8d585e:
	st.as r14,[gp,-0xb]
L_8d5862:
	mov.f r13,r0
L_8d5866:
	st.as r0,[gp,-0x27]
L_8d586a:
	st.as r0,[gp,0x61]
L_8d586e:
	beq_s L_8d587e
L_8d5870:
	mov_s r2,0x1001eec
L_8d5876:
	mov_s r0,0xe
L_8d5878:
	bl.d L_8edfb0
L_8d587c:
	mov_s r1,0x2
	.global L_8d587e
L_8d587e:
	bl L_8ca000
L_8d5882:
	ld_s r0,[r0]
L_8d5884:
	btst_s r0,0x8
L_8d5886:
	cmp.ne r13,0x0
L_8d588a:
	beq_s L_8d5894
L_8d588c:
	stw.as 0x61a8,[gp,0x3f]
	.global L_8d5894
L_8d5894:
	b L_8c0334
