/* ucode_cmd_0x00_handler @ 0x93a8d0, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac__cmd_56_57, mac_cfg__set_gp20_default_15748, memcpy_uc, rf__compute_tx_rx_sets, txrx_api_step_b_uc, ucode_cmd__apply_mac_cfg
 * Глобалы (через gp): 0x8005e4, 0x8005e6, 0x8005e8, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x00_handler
ucode_cmd_0x00_handler:
	.global L_93a8d0
L_93a8d0:
	push_s blink
L_93a8d2:
	bl L_920234
L_93a8d6:
	mov_s r13,r0
L_93a8d8:
	ld_s r0,[r0,0x40]
L_93a8da:
	mov_s r14,0x802940
L_93a8e0:
	st.as r0,[gp,-0x3]
L_93a8e4:
	bl.d L_92f320
L_93a8e8:
	mov_s r0,r13
L_93a8ea:
	add r0,r14,0x1c
L_93a8ee:
	add r1,r13,0x30
L_93a8f2:
	bl.d L_920330
L_93a8f6:
	mov_s r2,0xc
L_93a8f8:
	bl.d L_936acc
L_93a8fc:
	add r0,r14,0x1c
L_93a900:
	mov_s r0,0x857280
L_93a906:
	ldb_s r0,[r0,0xe]
L_93a908:
	mov_s r1,0x1
L_93a90a:
	cmp_s r0,0x0
L_93a90c:
	sub.le r1,r1,r1
L_93a910:
	mov_s r0,0x2
L_93a912:
	add3_s r0,r0,r1
L_93a914:
	stw.as r0,[gp,-0x10]
L_93a918:
	stw.as r0,[gp,-0xf]
L_93a91c:
	bl.d L_92f4b0
L_93a920:
	ld_s r0,[r13,0x40]
L_93a922:
	mov_s r1,0x886000
L_93a928:
	ld_s r0,[r1,0x18]
L_93a92a:
	ld_s r1,[r1,0x1c]
L_93a92c:
	stw.as r0,[gp,0x5e]
L_93a930:
	lsr_s r0,r0,0x10
L_93a932:
	stw.as r0,[gp,0x5f]
L_93a936:
	bl.d L_9368ac
L_93a93a:
	stw.as r1,[gp,0x60]
L_93a93e:
	mov_s r0,0x1
L_93a940:
	mov_s r1,0x8013c4
L_93a946:
	stb_s r0,[r1,0xc]
L_93a948:
	mov_s r0,0x40
L_93a94a:
	stb_s r0,[r1,0xd]
L_93a94c:
	mov_s r0,0x8020c4
L_93a952:
	st 0x29528,[r0, 0x20]
L_93a95a:
	mov_s r0,0x889480
L_93a960:
	ld_s r0,[r0,0x8]
L_93a962:
	bl.d L_92102c
L_93a966:
	st.as r0,[gp,0x5e]
L_93a96a:
	b L_9202a4
L_93a96e:
	nop_s
