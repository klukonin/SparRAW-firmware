/* conn_msm__on_own_start_link__unresourced @ 0x8e282c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_main_sm.cpp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn_msm__on_own_start_link__ready_for_assoc, fw_sysassert_fatal, get_g_800450, lmac_if_send_cmd_0x05_8f1074
 */
	.section .text.conn_msm__on_own_start_link__unresourced,"ax",@progbits
	.global conn_msm__on_own_start_link__unresourced
conn_msm__on_own_start_link__unresourced:
L_8e282c:
	push_s blink
L_8e282e:
	bl L_8c02bc
L_8e2832:
	mov_s r13,r0
L_8e2834:
	mov_s r14,r1
L_8e2836:
	brlo.d r1,0x8,L_8e2852
L_8e283a:
	mov_s r16,r2
L_8e283c:
	mov_s r0,blink
L_8e283e:
	mov_s r2,0x100f6f0
L_8e2844:
	mov_s r1,0x144a
L_8e284a:
	bl.d L_8c82c0
L_8e284e:
	mov_s r3,0xf3
L_8e2850:
	b_s L_8e286e
	.global L_8e2852
L_8e2852:
	ld_s r0,[r13,0x2c]
L_8e2854:
	stb_s r14,[r0,0x8]
L_8e2856:
	ld_s r0,[r13,0x2c]
L_8e2858:
	bl.d L_8f1074
L_8e285c:
	mov_s r1,0x0
L_8e285e:
	bl.d L_8e243c
L_8e2862:
	ld_s r0,[r13,0x2c]
L_8e2864:
	mov_s r0,r13
L_8e2866:
	mov_s r1,r14
L_8e2868:
	bl.d L_8de71c
L_8e286c:
	mov_s r2,r16
	.global L_8e286e
L_8e286e:
	b L_8c0324
L_8e2872:
	nop_s
