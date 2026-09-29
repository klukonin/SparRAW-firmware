/* lm_if__inject_evt_b @ 0x8de824, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_if.cpp
 * Зовут его: conn_mgr__foreach_link_arm_timer, l2_mgr__scan_complete_handle
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_sysassert_fatal
 */
	.section .text.lm_if__inject_evt_b,"ax",@progbits
	.global lm_if__inject_evt_b
lm_if__inject_evt_b:
	.global L_8de824
L_8de824:
	push_s blink
L_8de826:
	push_s r13
L_8de828:
	mov_s r13,r0
L_8de82a:
	ld_s r0,[r0]
L_8de82c:
	breq_s r0,0,L_8de840
	.global L_8de82e
L_8de82e:
	ld_s r0,[r13]
L_8de830:
	mov_s r1,0xb
L_8de832:
	mov_s r2,0x0
L_8de834:
	mov_s r3,r2
L_8de836:
	bl.d L_8d6a1c
L_8de83a:
	mov_s r4,r2
L_8de83c:
	b L_8c033c
	.global L_8de840
L_8de840:
	mov_s r0,blink
L_8de842:
	mov_s r2,0x1010e10
L_8de848:
	mov_s r1,0x1263
L_8de84e:
	bl.d L_8c82c0
L_8de852:
	mov_s r3,0xa8
L_8de854:
	b_s L_8de82e
L_8de856:
	nop_s
