/* conn_main_sm__action_8e7a3c @ 0x8e7a3c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn_msm__on_own_start_link__ready_for_assoc, fw_sysassert_fatal, lmac_if__send_sta_cfg_05, rx_macq__program_desc_for_conn
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__action_8e7a3c
conn_main_sm__action_8e7a3c:
	.global L_8e7a3c
L_8e7a3c:
	push_s blink
L_8e7a3e:
	bl L_8c01dc
L_8e7a42:
	mov_s r13,r0
L_8e7a44:
	mov_s r14,r1
L_8e7a46:
	brlo.d r1,0x8,L_8e7a5a
L_8e7a4a:
	mov_s r16,r2
L_8e7a4c:
	mov_s r0,blink
L_8e7a4e:
	mov_s r1,0x1543
L_8e7a54:
	bl L_8c9b28
L_8e7a58:
	b_s L_8e7a76
	.global L_8e7a5a
L_8e7a5a:
	ld_s r0,[r13,0x8]
L_8e7a5c:
	stb_s r14,[r0,0x8]
L_8e7a5e:
	ld_s r0,[r13,0x8]
L_8e7a60:
	bl.d L_8e7604
L_8e7a64:
	mov_s r1,0x0
L_8e7a66:
	bl.d L_8e7690
L_8e7a6a:
	ld_s r0,[r13,0x8]
L_8e7a6c:
	mov_s r0,r13
L_8e7a6e:
	mov_s r1,r14
L_8e7a70:
	bl.d L_8e2aac
L_8e7a74:
	mov_s r2,r16
	.global L_8e7a76
L_8e7a76:
	b L_8c0244
L_8e7a7a:
	nop_s
